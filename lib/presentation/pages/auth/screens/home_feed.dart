import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:bloc_clean_arch/presentation/bloc/profile_media/profile_media_bloc.dart';
import 'package:bloc_clean_arch/presentation/widgets/weekly_highlight_card.dart';
import 'package:bloc_clean_arch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  List<String> images = [AppImages.cleanup, AppImages.cleanup2, AppImages.team];
  List<String> hightlightTitle = [
    'Clean Slate Saturday',
    'Green Machine Cleanup Crew',
    'Community Care Collective',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<ProfileMediaBloc, ProfileMediaState>(
              builder: (context, state) {
                if (state is ProfileMediaProfileImageSelectedState) {
                  return CustomUserAvatar(
                    showAddIcon: false,
                    userProfilePicture: state.profilePicture.path,
                  );
                } else {
                  return const CustomUserAvatar(showAddIcon: false);
                }
              },
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning, ☀️'),
                Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
          child: Text('Weekly highlights', style: textTheme.titleMedium?.copyWith(fontSize: )),
        ),

        // weekly highlights
        SizedBox(
          height: 227,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) => WeeklyHighlightCard(
                  image: images[index],
                  date: '12/10/2025',
                  highlightDescription: hightlightTitle[index],
                ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: images.length,
          ),
        ),

        //volunteer oportunities
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
          child: Text(
            'Volunteer Opportunities',
            style: textTheme.titleMedium,
          ),
        ),
        // user feed
        //tabs : pending, volunteer, completed,
        //pending, ->
        // have
        // volunteer -> has , *
        //
        // completed

        //tab
        // image with di
        //
      ],
    );
  }
}

// add page scroll indicator for weekly highlights