import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// contains the volunteer event(s) that user has registered
class VolunteerPage extends StatefulWidget {
  const VolunteerPage({super.key});

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    return BlocBuilder<VolunteerBloc, VolunteerState>(
      builder:
          (
            BuildContext context,
            VolunteerState volunteerState,
          ) => BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (BuildContext context, BookmarkState bookMarkState) {
              final registeredVolunteerEvents =
                  volunteerState.registeredVolunteerEvents;

              return registeredVolunteerEvents.isEmpty
                  ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.hand_raised),
                        Text(
                          Globals.emptyVolunteerPageText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                  : ListView.separated(
                    itemBuilder:
                        (context, index) => WajibikaReportFeedCard(
                          isVolunteerForThisReport: volunteerState
                              .registeredAsVolunteerForThisReport(
                                reportHomeFeedModel:
                                    registeredVolunteerEvents[index],
                              ),
                          imageUrl:
                              registeredVolunteerEvents[index].report_image_url,
                          username:
                              registeredVolunteerEvents[index]
                                  .reporter_username,
                          time: registeredVolunteerEvents[index].report_date,
                          description:
                              registeredVolunteerEvents[index].description,
                          volunteerCount:
                              registeredVolunteerEvents[index]
                                      .related_events
                                      .isEmpty
                                  ? 0
                                  : registeredVolunteerEvents[index]
                                      .related_events[0]
                                      .participants_count,
                          scheduleDate:
                              registeredVolunteerEvents[index]
                                      .related_events
                                      .isEmpty
                                  ? ''
                                  : registeredVolunteerEvents[index]
                                      .related_events[0]
                                      .scheduled_volunteer_date,
                          onVolunteerButtonPressed:
                              () => confirmVolunteerForThisEvent(
                                reportHomeFeedModel:
                                    registeredVolunteerEvents[index],
                              ),
                          isBookmarked: bookMarkState.isReportBookMarked(
                            reportHomeFeedModel:
                                registeredVolunteerEvents[index],
                          ),
                          onBookmarkButtonPressed:
                              () => context.read<BookmarkBloc>().add(
                                BookmarkEventToggleReportBookmarksPresence(
                                  reportHomeFeedModel:
                                      registeredVolunteerEvents[index],
                                ),
                              ),
                        ),
                    separatorBuilder:
                        (context, index) =>
                            const Divider(indent: 10, endIndent: 10),
                    itemCount:
                        context
                            .read<VolunteerBloc>()
                            .state
                            .registeredVolunteerEvents
                            .length,
                  );
            },
          ),
    );
  }
}
