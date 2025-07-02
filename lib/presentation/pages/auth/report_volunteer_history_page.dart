import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/date_formatter.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportVolunteerHistoryPage extends StatefulWidget {
  final String type; // report, volunteer for now

  // final ReportListSpecificDateModel? reportHistory;
  // final VolunteerListSpecificDateModel? volunteerHistory;

  const ReportVolunteerHistoryPage({
    super.key,
    required this.type,
    // this.reportHistory,
    // this.volunteerHistory,
  });

  @override
  State<ReportVolunteerHistoryPage> createState() =>
      _ReportVolunteerHistoryPageState();
}

class _ReportVolunteerHistoryPageState
    extends State<ReportVolunteerHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.type == 'report'
              ? Globals.reportHistoryPageTitle
              : Globals.volunteerHistoryPageTitle,
        ),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child:
            widget.type == 'report'
                ? BlocBuilder<
                  ReportVolunteerHistoryOnSpecificDateBloc,
                  ReportVolunteerHistoryOnSpecificDateState
                >(
                  builder: (context, reportState) {
                    final reportHistory =
                        reportState.reportListSpecificDateModel.reports;

                    return reportState.isLoading
                        ? const Center(
                          child: CustomLoadingIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                        : reportHistory.isEmpty
                        ? const Center(child: Text('No History to show'))
                        : ListView.builder(
                          itemCount: reportHistory.length,
                          itemBuilder:
                              (context, index) => ReportVolunteerHistoryCard(
                                isApproved: reportHistory[index].is_approved,
                                type: widget.type,
                                description: reportHistory[index].description,
                                date: weekdayMonthDayFomat(
                                  date: reportHistory[index].report_date,
                                ),
                              ),
                        );
                  },
                )
                : BlocBuilder<
                  ReportVolunteerHistoryOnSpecificDateBloc,
                  ReportVolunteerHistoryOnSpecificDateState
                >(
                  builder: (context, volunteerState) {
                    final volunteerHistory =
                        volunteerState.volunteerListSpecificDate.events;
                    return volunteerState.isLoading
                        ? const Center(
                          child: CustomLoadingIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                        : volunteerHistory.isEmpty
                        ? const Center(
                          child: Text('No Volunteer History to show'),
                        )
                        : ListView.builder(
                          itemCount: volunteerHistory.length,
                          itemBuilder:
                              (context, index) => ReportVolunteerHistoryCard(
                                isApproved: true,
                                type: 'volunteer',
                                description:
                                    volunteerHistory[index].report_description,
                                date: weekdayMonthDayFomat(
                                  date:
                                      volunteerHistory[index]
                                          .scheduled_volunteer_date,
                                ),
                              ),
                        );
                  },
                ),
        // : const Center(child: Text('Volunter History here')),
      ),
    );
  }
}
