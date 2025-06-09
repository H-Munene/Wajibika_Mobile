import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/providers/user_provider.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:bloc_clean_arch/presentation/widgets/weekly_highlight_card.dart';
import 'package:provider/provider.dart';

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
    final username = context.read<UserProvider>().userModel.username;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: welcome user  -> use rich text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  highlightColor: Colors.black,
                  regularText: 'Good Morning, ',
                  highlightedText: '$username☀️',
                ),

                // Wajibika points
                const Row(
                  children: [Text('Wajibika Points'), Spacer(), Text('17 wp')],
                ),
                // TODO: gauge range
                LinearProgressIndicator(
                  borderRadius: AppDimensions.circleBorderRadius,
                  value: 57 / 100,
                  minHeight: 10,
                  color: AppColors.primaryColor,
                  trackGap: 2,
                ),
              ],
            ),
            // tackled projects highlights
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
              child: Text(
                'Weekly highlights',
                style: textTheme.titleMedium?.copyWith(fontSize: 20),
              ),
            ),

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
        ),
      ),
    );
  }
}

// add page scroll indicator for weekly highlights
