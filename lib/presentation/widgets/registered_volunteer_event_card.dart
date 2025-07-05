// import 'package:bloc_clean_arch/core/core.dart';
// import 'package:bloc_clean_arch/presentation/date_formatter.dart';
// import 'package:bloc_clean_arch/presentation/presentation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class RegisteredVolunteerEventCard extends StatelessWidget {
//   const RegisteredVolunteerEventCard({
//     super.key,
//     required this.event_id,
//     required this.event_name,
//     required this.scheduled_volunteer_date,
//     required this.event_status,
//     required this.report_id,
//     required this.reporter_username,
//     required this.description,
//     required this.report_date,
//     required this.is_resolved_by_volunteer,
//     required this.is_resolved_by_council,
//     this.resolved_image_url,
//     required this.resolved_date,
//     required this.onVolunteerButtonPressed,
//     required this.volunteerCount,
//   });

//   final int event_id;
//   final String event_name;
//   final String scheduled_volunteer_date;
//   final String event_status;
//   final int report_id;
//   final String reporter_username;
//   final String description;
//   final String report_date;
//   final bool is_resolved_by_volunteer;
//   final bool is_resolved_by_council;
//   final String? resolved_image_url;
//   final String resolved_date;
//   final VoidCallback onVolunteerButtonPressed;
//   final int volunteerCount;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Card.outlined(
//       elevation: 2,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: AppDimensions.circleBorderRadius,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // report image
//           const SizedBox(height: 5),

//           // user avatar with time report was made
//           Padding(
//             padding: const EdgeInsets.only(left: 5),
//             child: Row(
//               spacing: 5,
//               children: [
//                 const CustomUserAvatar(showAddIcon: false),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(reporter_username, style: textTheme.bodySmall),
//                     Text(
//                       weekdayMonthDayFomat(date: report_date),
//                       style: textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 5),

//           // brief description of the context of image
//           Padding(
//             padding: const EdgeInsets.only(left: 5),
//             child: Text(description),
//           ),

//           // volunteer date + button
//           Padding(
//             padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: AppDimensions.circleBorderRadius,
//                     border: Border.all(),
//                   ),

//                   // volunteer date schedule
//                   child: ScheduleDate(
//                     scheduleDate: weekdayMonthDayFomat(
//                       date: scheduled_volunteer_date,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),

//                 //volunteer button with conditionally rendered avatars
//                 Stack(
//                   children: [
//                     CustomButtonWidget(
//                       makeButtonRounded: true,
//                       color: Colors.white,
//                       onPressed: onVolunteerButtonPressed,
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         spacing: 3,
//                         children: [
//                           Icon(
//                             CupertinoIcons.hand_raised_fill,
//                             color: Colors.black,
//                           ),
//                           Text(
//                             'Registered',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // conditionally rendered avatars
//                     Positioned(
//                       bottom: 0.5,
//                       right: 5,
//                       child: UserAvatarandOtherUserAvatWithCount(
//                         volunteerCount: volunteerCount,
//                         showMyAvatar: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
