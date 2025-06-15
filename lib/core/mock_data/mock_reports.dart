import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';

List<ReportModel> mockCloggedDrainReports = [
  ReportModel(
    reportCategory: Globals.reportCategoryItems[0],
    imageUrl: AppImages.clogged,
    volunteerCount: 3,
    username: 'User101',
    time: 'Mon, Jul 9',
    description: 'Clogged Drain as you get into the Siwaka Plaza back entrance',
    scheduleDate: 'Sat, Jul 14',
  ),
  ReportModel(
    reportCategory: Globals.reportCategoryItems[0],
    imageUrl: AppImages.clogged2,
    volunteerCount: 2,
    username: 'User102',
    time: 'Tue, Jul 9',
    description: 'Clogged Drain towards Madaraka Primary School',
    scheduleDate: 'Sat, Jul 14',
  ),
];

List<ReportModel> mockNegligentDumpingReports = [
  ReportModel(
    reportCategory: Globals.reportCategoryItems[1],
    imageUrl: AppImages.garbage1,
    volunteerCount: 3,
    username: 'User103',
    time: 'Mon, Jul 7',
    description: 'Negligent Dumping along Ole Sangale Road past Weche Court',
    scheduleDate: 'Sat, Jul 14',
  ),
  ReportModel(
    reportCategory: Globals.reportCategoryItems[1],
    imageUrl: AppImages.garbage2,
    volunteerCount: 2,
    username: 'User108',
    time: 'Tue, Jul 10',
    description: 'Improper Waster close to Shopping Centre',
    scheduleDate: 'Sat, Jul 14',
  ),
];
