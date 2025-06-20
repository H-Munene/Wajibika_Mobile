import 'package:bloc_clean_arch/presentation/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

// builds a card with the report image, a description, the user and time the
// report was submitted
class WajibikaReportFeedCard extends StatelessWidget {
  final String imageUrl;
  final int volunteerCount;
  final String username;
  final String report_date;
  final String description;
  final String scheduleDate;
  final VoidCallback onVolunteerButtonPressed;
  final void Function() onBookmarkButtonPressed;
  final bool isBookmarked;
  final bool isVolunteerForThisReport;
  final bool showMyAvatar;

  const WajibikaReportFeedCard({
    super.key,
    required this.username,
    required this.report_date,
    required this.description,
    required this.volunteerCount,
    required this.scheduleDate, // i.e "EEE, MMM d, ''yyyy"-> Wed, Jul 10, '2025
    this.showMyAvatar = false,
    required this.onVolunteerButtonPressed,
    required this.onBookmarkButtonPressed,
    this.isBookmarked = false,
    required this.imageUrl,
    required this.isVolunteerForThisReport,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // final scheduleDateMonthDay = '${scheduleDate.substring(5, 11)}';
    // final scheduleDateDay = '${scheduleDate.substring(0, 3)}';

    return Card.outlined(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.circleBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // report image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              fit: BoxFit.cover,
              imageUrl,
              height: AppDimensions.reportHomeFeedImageHeightWidth,
              cacheHeight: AppDimensions.reportHomeFeedImageHeightWidth.toInt(),
              width: AppDimensions.reportHomeFeedImageHeightWidth,
              cacheWidth: AppDimensions.reportHomeFeedImageHeightWidth.toInt(),
            ),
          ),
          const SizedBox(height: 5),

          // user avatar with time report was made
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              spacing: 5,
              children: [
                const CustomUserAvatar(showAddIcon: false),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username, style: textTheme.bodySmall),
                    Text(
                      weekdayMonthDayFomat(date: report_date),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: onBookmarkButtonPressed,
                  icon: Icon(
                    isBookmarked
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),

          // brief description of the context of image
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(description),
          ),

          // volunteer date + button
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Row(
              children: [
                if (scheduleDate.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppDimensions.circleBorderRadius,
                      border: Border.all(),
                    ),

                    // volunteer date schedule
                    child: _ScheduleDate(
                      scheduleDate: weekdayMonthDayFomat(date: scheduleDate),
                    ),
                  ),
                const Spacer(),

                //volunteer button with conditionally rendered avatars
                Stack(
                  children: [
                    CustomButtonWidget(
                      makeButtonRounded: true,
                      color:
                          isVolunteerForThisReport
                              ? Colors.white
                              : Colors.black,
                      onPressed: onVolunteerButtonPressed,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 3,
                        children: [
                          Icon(
                            isVolunteerForThisReport
                                ? CupertinoIcons.hand_raised_fill
                                : CupertinoIcons.hand_raised,
                            color:
                                isVolunteerForThisReport
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          Text(
                            isVolunteerForThisReport
                                ? 'Registered'
                                : 'Volunteer',
                            style: TextStyle(
                              color:
                                  isVolunteerForThisReport
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // conditionally rendered avatars
                    Positioned(
                      bottom: 0.5,
                      right: 5,
                      child: _UserAvatarandOtherUserAvatWithCount(
                        volunteerCount: volunteerCount,
                        showMyAvatar: isVolunteerForThisReport,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// displays the volunteer date
class _ScheduleDate extends StatelessWidget {
  const _ScheduleDate({required this.scheduleDate});

  final String scheduleDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        spacing: 2,
        children: [
          const Icon(CupertinoIcons.calendar_today),
          Text(scheduleDate, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// conditionally diplays the user avatar and another user avatar with the count
// to signify number of volunteers in a report
class _UserAvatarandOtherUserAvatWithCount extends StatelessWidget {
  final bool showMyAvatar; // current user avatar
  final int volunteerCount; // number of volunteers for this report

  const _UserAvatarandOtherUserAvatWithCount({
    this.showMyAvatar = false,
    required this.volunteerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // current user avatar
        if (showMyAvatar)
          BlocBuilder<ProfileMediaBloc, ProfileMediaState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 7,
                backgroundImage:
                    state.profileMediaStatus ==
                            ProfileMediaStatus.profilePicturePresent
                        ? Image.file(File(state.profilePicture)).image
                        : Image.asset(AppImages.blankProfilePicture).image,

                backgroundColor: AppColors.noImageBackgroundColor,
              );
            },
          ),
        // avatar to signify other volunteers
        if (volunteerCount >= 1)
          Row(
            spacing: 1,
            children: [
              CircleAvatar(
                radius: 7,
                backgroundImage:
                    Image.asset(AppImages.blankProfilePicture).image,

                backgroundColor: AppColors.noImageBackgroundColor,
              ),
              Text(
                volunteerCount <= 5 ? '$volunteerCount' : '5+',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
      ],
    );
  }
}
