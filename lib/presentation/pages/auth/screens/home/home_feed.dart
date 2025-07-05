import 'dart:convert';

import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    context.read<HomeFeedBloc>().add(HomeFeedGetFeed());

    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  Future<void> refreshFeed() async {
    context.read<HomeFeedBloc>().add(HomeFeedGetFeed());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeFeedBloc, HomeFeedState>(
      builder: (context, homeFeedState) {
        // unresolved clogged reports
        final cloggedDrains =
            homeFeedState.homeFeedModel.clogged_drain
                .where(
                  (report) =>
                      !report.is_resolved_by_council &&
                      !report.is_resolved_by_volunteer,
                )
                .toList();

        // resolved clogged reports
        final resolvedCloggedDrains =
            homeFeedState.homeFeedModel.clogged_drain
                .where(
                  (report) =>
                      report.is_resolved_by_council ||
                      report.is_resolved_by_volunteer,
                )
                .toList();

        // unresolved negligent reports
        final negligentDumping =
            homeFeedState.homeFeedModel.negligent_dumping
                .where(
                  (report) =>
                      !report.is_resolved_by_council &&
                      !report.is_resolved_by_volunteer,
                )
                .toList();

        // resolved negligent reports
        final resolvedNegligentDumping =
            homeFeedState.homeFeedModel.negligent_dumping
                .where(
                  (report) =>
                      report.is_resolved_by_council ||
                      report.is_resolved_by_volunteer,
                )
                .toList();

        return homeFeedState.isLoading
            ? const Center(
              child: CustomLoadingIndicator(
                color: AppColors.primaryColor,
                size: 35,
              ),
            )
            : Padding(
              padding: AppDimensions.pagePadding,
              child: NestedScrollView(
                headerSliverBuilder:
                    (context, isInnerBoxScrolled) => [
                      SliverToBoxAdapter(
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final username = context
                                    .read<UserRepository>()
                                    .getUserName()
                                    .fold(
                                      (_) => 'user',
                                      (username) => username,
                                    );

                                return CustomRichText(
                                  highlightColor: Colors.black,
                                  regularText: 'Hello, ',
                                  highlightedText: username,
                                );
                              },
                            ),

                            if (!homeFeedState.isLoading)
                              BlocBuilder<HomeFeedBloc, HomeFeedState>(
                                builder: (context, state) {
                                  final wajibikaPoints =
                                      state
                                          .homeFeedModel
                                          .current_user_wajibika_points;

                                  return WajibikaPointsProgress(
                                    wajibikaPoints: wajibikaPoints ?? 0,
                                  );
                                },
                              ),
                            Text(
                              Globals.homeWeekHighlightsSectionTitle,
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            WeekHighlights(
                              resolvedCloggedDrains: resolvedCloggedDrains,
                              resolvedNegligentDumping:
                                  resolvedNegligentDumping,
                            ),

                            const Divider(thickness: 2, color: Colors.black),
                          ],
                        ),
                      ),

                      SliverAppBar(
                        centerTitle: false,
                        pinned: true,
                        surfaceTintColor: Colors.white,
                        primary: false,
                        toolbarHeight: 20,
                        title: Text(
                          Globals.homereportsSectionTitle,
                          style: textTheme.titleMedium?.copyWith(fontSize: 20),
                        ),
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(
                              child: Text(
                                Globals.homeReportsTabTitle1,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                Globals.homeReportsTabTitle2,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    if (cloggedDrains.isEmpty)
                      const Center(child: Text('No Feed at the moment'))
                    else
                      RefreshIndicator(
                        onRefresh: refreshFeed,
                        child: ListView.separated(
                          itemBuilder:
                              (
                                context,
                                index,
                              ) => BlocBuilder<VolunteerBloc, VolunteerState>(
                                builder: (context, volunteerState) {
                                  return BlocBuilder<
                                    BookmarkBloc,
                                    BookmarkState
                                  >(
                                    builder:
                                        (context, bookmarkState) =>
                                        // clogged drain
                                        WajibikaReportFeedCard(
                                          isVolunteerForThisReport:
                                              cloggedDrains[index]
                                                  .is_volunteer ||
                                              volunteerState
                                                  .registeredAsVolunteerForThisReport(
                                                    reportHomeFeedModel:
                                                        cloggedDrains[index],
                                                  ),
                                          imageUrl:
                                              cloggedDrains[index]
                                                  .report_image_url,
                                          username:
                                              cloggedDrains[index]
                                                  .reporter_username,
                                          report_date:
                                              cloggedDrains[index].report_date,
                                          description:
                                              cloggedDrains[index].description,
                                          volunteerCount:
                                              cloggedDrains[index]
                                                      .related_events
                                                      .isEmpty
                                                  ? 0
                                                  : cloggedDrains[index]
                                                      .related_events[0]
                                                      .participants_count,
                                          scheduleDate:
                                              cloggedDrains[index]
                                                      .related_events
                                                      .isEmpty
                                                  ? ''
                                                  : cloggedDrains[index]
                                                      .related_events[0]
                                                      .scheduled_volunteer_date,
                                          onVolunteerButtonPressed:
                                              () =>
                                                  confirmVolunteerForThisEvent(
                                                    reportHomeFeedModel:
                                                        cloggedDrains[index],
                                                  ),
                                          isBookmarked: bookmarkState
                                              .isReportBookMarked(
                                                reportHomeFeedModel:
                                                    cloggedDrains[index],
                                              ),
                                          onBookmarkButtonPressed:
                                              () => context
                                                  .read<BookmarkBloc>()
                                                  .add(
                                                    BookmarkEventToggleReportBookmarksPresence(
                                                      reportHomeFeedModel:
                                                          cloggedDrains[index],
                                                    ),
                                                  ),
                                        ),
                                  );
                                },
                              ),
                          separatorBuilder:
                              (context, index) =>
                                  const Divider(indent: 10, endIndent: 10),
                          itemCount: cloggedDrains.length,
                        ),
                      ),
                    if (negligentDumping.isEmpty)
                      const Center(child: Text('No Feed at the moment'))
                    else
                      RefreshIndicator(
                        onRefresh: refreshFeed,
                        child: ListView.separated(
                          itemBuilder:
                              (
                                context,
                                index,
                              ) => BlocBuilder<VolunteerBloc, VolunteerState>(
                                builder: (context, volunteerState) {
                                  return BlocBuilder<
                                    BookmarkBloc,
                                    BookmarkState
                                  >(
                                    builder: (context, bookmarkState) {
                                      return WajibikaReportFeedCard(
                                        isVolunteerForThisReport:
                                            negligentDumping[index]
                                                .is_volunteer ||
                                            volunteerState
                                                .registeredAsVolunteerForThisReport(
                                                  reportHomeFeedModel:
                                                      negligentDumping[index],
                                                ),
                                        imageUrl:
                                            negligentDumping[index]
                                                .report_image_url,
                                        username:
                                            negligentDumping[index]
                                                .reporter_username,
                                        report_date:
                                            negligentDumping[index].report_date,
                                        description:
                                            negligentDumping[index].description,
                                        volunteerCount:
                                            negligentDumping[index]
                                                    .related_events
                                                    .isEmpty
                                                ? 0
                                                : negligentDumping[index]
                                                    .related_events[0]
                                                    .participants_count,
                                        scheduleDate:
                                            negligentDumping[index]
                                                    .related_events
                                                    .isEmpty
                                                ? ''
                                                : negligentDumping[index]
                                                    .related_events[0]
                                                    .scheduled_volunteer_date,
                                        onVolunteerButtonPressed:
                                            () => confirmVolunteerForThisEvent(
                                              reportHomeFeedModel:
                                                  negligentDumping[index],
                                            ),
                                        isBookmarked: bookmarkState
                                            .isReportBookMarked(
                                              reportHomeFeedModel:
                                                  negligentDumping[index],
                                            ),
                                        onBookmarkButtonPressed:
                                            () => context.read<BookmarkBloc>().add(
                                              BookmarkEventToggleReportBookmarksPresence(
                                                reportHomeFeedModel:
                                                    negligentDumping[index],
                                              ),
                                            ),
                                      );
                                    },
                                  );
                                },
                              ),
                          separatorBuilder:
                              (context, index) =>
                                  const Divider(indent: 10, endIndent: 10),
                          itemCount: negligentDumping.length,
                        ),
                      ),
                  ],
                ),
              ),
            );
      },
    );
  }

  Future<void> confirmVolunteerForThisEvent({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) async {
    // final isVolunteer = context
    //     .read<VolunteerBloc>()
    //     .state
    //     .registeredAsVolunteerForThisReport(
    //       reportHomeFeedModel: reportHomeFeedModel,
    //     );
    final isVolunteer = reportHomeFeedModel.is_volunteer;

    CustomDialogBottomAppSheet.cupertinoAlertDialog(
      context: context,
      title:
          isVolunteer
              ? Globals.unregisterAsVolunteerFromThisEventAlertTitle
              : Globals.volunterForThisEventAlertTitle,
      content:
          isVolunteer
              ? Globals.unregisterAsVolunterFromThisEventAlertContent
              : Globals.volunterForThisEventAlertContent,
      onDestructiveActionPressed: () async {
        final token = context.read<UserRepository>().getToken().fold(
          (_) => '',
          (token) => token,
        );

        // if is volunteer trigger unregister event
        if (isVolunteer) {
          final Uri url = Uri.parse(
            LocalhostEndpoints.unregisterVolunteerEventBaseEndpoint(
              reportID: reportHomeFeedModel.report_id,
            ),
          );

          final request = await http.delete(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
              'Access-Control-Allow-Headers':
                  'Origin, Content-Type, X-Auth-Token, Authorization',
            },
          );

          if (request.statusCode == 200) {
            SnackbarDefinition.showSuccessSnackbar(
              context: context,
              message: 'Unregistered as a volunteer for this report',
            );
            context.read<VolunteerBloc>().add(
              VolunteerEventToggleVolunteerPresence(
                reportHomeFeedModel: reportHomeFeedModel,
              ),
            );
          } else {
            SnackbarDefinition.showErrorSnackbar(
              context: context,
              message: 'Failed to unregister. Try again!',
            );
          }
        }
        // if is not volunteer trigger register event
        else {
          final Uri url = Uri.parse(
            LocalhostEndpoints.registerAsVolunteerEndpoint(
              reportID: reportHomeFeedModel.report_id,
            ),
          );

          final request = await http.post(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
              'Access-Control-Allow-Headers':
                  'Origin, Content-Type, X-Auth-Token, Authorization',
            },
          );

          if (request.statusCode == 200) {
            SnackbarDefinition.showSuccessSnackbar(
              context: context,
              message: 'Registered as a volunteer for this report',
            );
            context.read<VolunteerBloc>().add(
              VolunteerEventToggleVolunteerPresence(
                reportHomeFeedModel: reportHomeFeedModel,
              ),
            );
          } else {
            SnackbarDefinition.showErrorSnackbar(
              context: context,
              message: 'Failed to register. Try again!',
            );
          }
        }

        Navigator.of(context).pop();
      },
    );
  }
}
