import 'package:bloc_clean_arch/presentation/bloc/home_feed/home_feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  void confirmVolunteerForThisEvent({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    final isVolunteer = context
        .read<VolunteerBloc>()
        .state
        .registeredAsVolunteerForThisReport(
          reportHomeFeedModel: reportHomeFeedModel,
        );

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
      onDestructiveActionPressed: () {
        context.read<VolunteerBloc>().add(
          VolunteerEventToggleVolunteerPresence(
            reportHomeFeedModel: reportHomeFeedModel,
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: move from here
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<HomeFeedBloc, HomeFeedState>(
      builder: (context, homeFeedState) {
        final cloggedDrains = homeFeedState.homeFeedModel.clogged_drain;
        final negligentDumping = homeFeedState.homeFeedModel.negligent_dumping;

        return Skeletonizer(
          enableSwitchAnimation: true,

          enabled: homeFeedState.isLoading,
          child: Padding(
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
                              final username =
                                  (state as AuthLoggedIn).userModel.username;

                              return CustomRichText(
                                highlightColor: Colors.black,
                                regularText: 'Good Morning, ',
                                highlightedText: '$username☀️',
                              );
                            },
                          ),

                          if (!homeFeedState.isLoading)
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final wajibikaPoints =
                                    (state as AuthLoggedIn)
                                        .userModel
                                        .wajibika_points;

                                return WajibikaPointsProgress(
                                  wajibikaPoints: wajibikaPoints,
                                );
                              },
                            ),
                          Text(
                            Globals.homeWeekHighlightsSectionTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const WeekHighlights(),

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
                    const Text('No Feed at the moment')
                  else
                    ListView.separated(
                      itemBuilder:
                          (
                            context,
                            index,
                          ) => BlocBuilder<VolunteerBloc, VolunteerState>(
                            builder: (context, volunteerState) {
                              return BlocBuilder<BookmarkBloc, BookmarkState>(
                                builder:
                                    (context, bookmarkState) =>
                                    // clogged drain
                                    WajibikaReportFeedCard(
                                      // isVolunteerForThisReport: volunteerState
                                      //     .registeredAsVolunteerForThisReport(
                                      //       reportHomeFeedModel:
                                      //           cloggedDrains[index],
                                      //     ),
                                      isVolunteerForThisReport:
                                          cloggedDrains[index].is_volunteer ||
                                          volunteerState
                                              .registeredAsVolunteerForThisReport(
                                                reportHomeFeedModel:
                                                    cloggedDrains[index],
                                              ),
                                      imageUrl:
                                          cloggedDrains[index].report_image_url,
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
                                          () => confirmVolunteerForThisEvent(
                                            reportHomeFeedModel:
                                                cloggedDrains[index],
                                          ),
                                      isBookmarked: bookmarkState
                                          .isReportBookMarked(
                                            reportHomeFeedModel:
                                                cloggedDrains[index],
                                          ),
                                      onBookmarkButtonPressed:
                                          () => context.read<BookmarkBloc>().add(
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
                  if (negligentDumping.isEmpty)
                    const Text('No Feed at the moment')
                  else
                    ListView.separated(
                      itemBuilder:
                          (
                            context,
                            index,
                          ) => BlocBuilder<VolunteerBloc, VolunteerState>(
                            builder: (context, volunteerState) {
                              return BlocBuilder<BookmarkBloc, BookmarkState>(
                                builder: (context, bookmarkState) {
                                  return WajibikaReportFeedCard(
                                    // isVolunteerForThisReport: volunteerState
                                    //     .registeredAsVolunteerForThisReport(
                                    //       reportHomeFeedModel:
                                    //           negligentDumping[index],
                                    //     ),
                                    isVolunteerForThisReport:
                                        negligentDumping[index].is_volunteer ||
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
