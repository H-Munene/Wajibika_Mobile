import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      itemBuilder:
          (context, index) => WajibikaReportFeedCard(
            imageUrl: AppImages.clogged3,
            onBookmarkButtonPressed: () {},
            showMyAvatar: true,
            scheduleDate: 'Sat, July 12',
            volunteerCount: 2,
            username: 'User101',
            time: '7hrs ago',
            description: 'Clogged drain around Madaraka shopping centre',
            onVolunteerButtonPressed: () {},
          ),
      separatorBuilder:
          (context, index) => const Divider(indent: 10, endIndent: 10),
      itemCount: 10,
    );
  }
}
