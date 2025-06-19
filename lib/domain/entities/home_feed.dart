import 'package:bloc_clean_arch/data/data.dart';

class HomeFeedEntity {
  HomeFeedEntity({
    required this.clogged_drain,
    required this.negligent_dumping,
  });

  final List<ReportHomeFeedModel> clogged_drain;
  final List<ReportHomeFeedModel> negligent_dumping;
}
