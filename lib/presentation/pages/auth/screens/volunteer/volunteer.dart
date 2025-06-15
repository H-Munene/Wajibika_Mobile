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
                                reportModel: registeredVolunteerEvents[index],
                              ),
                          imageUrl: registeredVolunteerEvents[index].imageUrl,
                          username: registeredVolunteerEvents[index].username,
                          time: registeredVolunteerEvents[index].time,
                          description:
                              registeredVolunteerEvents[index].description,
                          volunteerCount:
                              registeredVolunteerEvents[index].volunteerCount,
                          scheduleDate:
                              registeredVolunteerEvents[index].scheduleDate,
                          onVolunteerButtonPressed:
                              () => confirmVolunteerForThisEvent(
                                reportModel: registeredVolunteerEvents[index],
                              ),
                          isBookmarked: bookMarkState.isReportBookMarked(
                            reportModel: registeredVolunteerEvents[index],
                          ),
                          onBookmarkButtonPressed:
                              () => context.read<BookmarkBloc>().add(
                                BookmarkEventToggleReportBookmarksPresence(
                                  reportModel: registeredVolunteerEvents[index],
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
