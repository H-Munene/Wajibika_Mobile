import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// contains the volunteer event(s) that user has registered
class VolunteerPage extends StatefulWidget {
  const VolunteerPage({super.key});

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  bool isLoading = false;

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
          (BuildContext context, VolunteerState volunteerState) =>
              BlocBuilder<BookmarkBloc, BookmarkState>(
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
                              showImage: false,
                              isVolunteerForThisReport: volunteerState
                                  .registeredAsVolunteerForThisReport(
                                    reportHomeFeedModel:
                                        registeredVolunteerEvents[index],
                                  ),
                              imageUrl:
                                  registeredVolunteerEvents[index]
                                      .report_image_url,
                              username:
                                  registeredVolunteerEvents[index]
                                      .reporter_username,
                              report_date:
                                  registeredVolunteerEvents[index].report_date,
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
                              onVolunteerButtonPressed: () async {
                                await unregisterAsVolunteerForThisEvent(
                                  reportHomeFeedModel:
                                      registeredVolunteerEvents[index],
                                );
                              },
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

  Future<void> unregisterAsVolunteerForThisEvent({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) async {
    final token = context.read<UserRepository>().getToken().fold(
      (_) => '',
      (token) => token,
    );

    CustomDialogBottomAppSheet.cupertinoAlertDialog(
      context: context,
      title: Globals.unregisterAsVolunteerFromThisEventAlertTitle,
      content: Globals.unregisterAsVolunterFromThisEventAlertContent,
      onDestructiveActionPressed: () async {
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
        Navigator.of(context).pop();
      },
    );
  }
}
