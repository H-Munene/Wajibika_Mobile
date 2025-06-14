import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/widgets/report_history_card.dart';
import 'package:flutter/material.dart';

class ReportVolunteerHistoryPage extends StatelessWidget {
  final String type; // report, volunteer for now

  // final List<Volunteer> reportVolunteerHistory;
  // final List<Report> reportVolunteerHistory;

  const ReportVolunteerHistoryPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          type == 'report'
              ? Globals.reportHistoryPageTitle
              : Globals.volunteerHistoryPageTitle,
        ),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder:
              (context, index) => ReportVolunteerHistoryCard(
                type: type,
                description:
                    'Improper garbage disposal around Madaraka shopping centre',
                date: 'Sat, July 12 2025',
              ),
        ),
      ),
    );
  }
}
