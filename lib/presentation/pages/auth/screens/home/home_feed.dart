import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> with TickerProviderStateMixin {
  int wajibikaPoints = 162;
  late TabController _tabController;
  List<ReportModel> cloggedDrainReports = [
    ReportModel(
      reportCategory: Globals.reportCategoryItems[0],
      imageUrl: AppImages.clogged,
      volunteerCount: 3,
      username: 'User101',
      time: 'Mon, Jul 9',
      description:
          'Clogged Drain as you get into the Siwaka Plaza back entrance',
      scheduleDate: 'Sat, Jul 21',
    ),
    ReportModel(
      reportCategory: Globals.reportCategoryItems[0],
      imageUrl: AppImages.clogged2,
      volunteerCount: 2,
      username: 'User102',
      time: 'Tue, Jul 9',
      description: 'Clogged Drain towards Madaraka Primary School',
      scheduleDate: 'Sat, Jul 21',
    ),
  ];

  List<ReportModel> negligentDumpingReports = [
    ReportModel(
      reportCategory: Globals.reportCategoryItems[1],
      imageUrl: AppImages.garbage1,
      volunteerCount: 3,
      username: 'User103',
      time: 'Mon, Jul 7',
      description: 'Negligent Dumping along Ole Sangale Road past Weche Court',
      scheduleDate: 'Sat, Jul 21',
    ),
    ReportModel(
      reportCategory: Globals.reportCategoryItems[1],
      imageUrl: AppImages.garbage2,
      volunteerCount: 2,
      username: 'User108',
      time: 'Tue, Jul 10',
      description: 'Improper Waster close to Shopping Centre',
      scheduleDate: 'Sat, Jul 21',
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void confirmVolunteerForThisEvent({required ReportModel reportModel}) {
    final isVolunteer = context
        .read<VolunteerBloc>()
        .state
        .registeredAsVolunteerForThisReport(reportModel: reportModel);

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
      // TODO: mark as volunteer for event -> will need report id
      onDestructiveActionPressed: () {
        context.read<VolunteerBloc>().add(
          VolunteerEventToggleVolunteerPresence(reportModel: reportModel),
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final username = context.read<UserRepository>().getUserName().fold(
      (_) => 'user',
      (username) => username,
    );

    return Padding(
      padding: AppDimensions.pagePadding,
      child: NestedScrollView(
        headerSliverBuilder:
            (context, isInnerBoxScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      highlightColor: Colors.black,
                      regularText: 'Good Morning, ',
                      highlightedText: '$username☀️',
                    ),

                    WajibikaPointsProgress(wajibikaPoints: wajibikaPoints),
                    Text(
                      Globals.homeWeekHighlightsSectionTitle,
                      style: textTheme.titleMedium?.copyWith(fontSize: 20),
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
                        style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        Globals.homeReportsTabTitle2,
                        style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.separated(
              itemBuilder:
                  (
                    context,
                    index,
                  ) => BlocBuilder<VolunteerBloc, VolunteerState>(
                    builder: (context, volunteerState) {
                      return BlocBuilder<BookmarkBloc, BookmarkState>(
                        builder:
                            (context, bookmarkState) => WajibikaReportFeedCard(
                              isVolunteerForThisReport: volunteerState
                                  .registeredAsVolunteerForThisReport(
                                    reportModel: cloggedDrainReports[index],
                                  ),
                              imageUrl: cloggedDrainReports[index].imageUrl,
                              username: cloggedDrainReports[index].username,
                              time: cloggedDrainReports[index].time,
                              description:
                                  cloggedDrainReports[index].description,
                              volunteerCount:
                                  cloggedDrainReports[index].volunteerCount,
                              scheduleDate:
                                  cloggedDrainReports[index].scheduleDate,
                              onVolunteerButtonPressed:
                                  () => confirmVolunteerForThisEvent(
                                    reportModel: cloggedDrainReports[index],
                                  ),
                              isBookmarked: bookmarkState.isReportBookMarked(
                                reportModel: cloggedDrainReports[index],
                              ),
                              onBookmarkButtonPressed:
                                  () => context.read<BookmarkBloc>().add(
                                    BookmarkEventToggleReportBookmarksPresence(
                                      reportModel: cloggedDrainReports[index],
                                    ),
                                  ),
                            ),
                      );
                    },
                  ),
              separatorBuilder:
                  (context, index) => const Divider(indent: 10, endIndent: 10),
              itemCount: cloggedDrainReports.length,
            ),
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
                            isVolunteerForThisReport: volunteerState
                                .registeredAsVolunteerForThisReport(
                                  reportModel: negligentDumpingReports[index],
                                ),
                            imageUrl: negligentDumpingReports[index].imageUrl,
                            username: negligentDumpingReports[index].username,
                            time: negligentDumpingReports[index].time,
                            description:
                                negligentDumpingReports[index].description,
                            volunteerCount:
                                negligentDumpingReports[index].volunteerCount,
                            scheduleDate:
                                negligentDumpingReports[index].scheduleDate,
                            onVolunteerButtonPressed:
                                () => confirmVolunteerForThisEvent(
                                  reportModel: negligentDumpingReports[index],
                                ),
                            isBookmarked: bookmarkState.isReportBookMarked(
                              reportModel: negligentDumpingReports[index],
                            ),
                            onBookmarkButtonPressed:
                                () => context.read<BookmarkBloc>().add(
                                  BookmarkEventToggleReportBookmarksPresence(
                                    reportModel: negligentDumpingReports[index],
                                  ),
                                ),
                          );
                        },
                      );
                    },
                  ),
              separatorBuilder:
                  (context, index) => const Divider(indent: 10, endIndent: 10),
              itemCount: negligentDumpingReports.length,
            ),
          ],
        ),
      ),
    );
  }
}
