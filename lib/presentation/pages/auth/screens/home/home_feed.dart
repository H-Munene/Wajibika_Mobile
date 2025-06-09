import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/home/week_highlights.dart';
import 'package:bloc_clean_arch/presentation/providers/user_provider.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_richtext.dart';
import 'package:bloc_clean_arch/presentation/widgets/wajibika_points_progress.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:provider/provider.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> with TickerProviderStateMixin {
  int wajibikaPoints = 47;
  List<String> images = [AppImages.cleanup, AppImages.cleanup2, AppImages.team];

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

                WajibikaPointsProgress(wajibikaPoints: wajibikaPoints),
              ],
            ),
            // tackled projects highlights
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
              child: Text(
                'Week highlights',
                style: textTheme.titleMedium?.copyWith(fontSize: 20),
              ),
            ),

            const WeekHighlights(),
          ],
        ),
      ),
    );
  }
}

// add page scroll indicator for weekly highlights
