import 'package:bloc_clean_arch/domain/entities/report_home_feed_entity.dart';

class HomeFeedEntity {
  HomeFeedEntity({
    required this.clogged_drain,
    required this.negligent_dumping,
  });

  final List<ReportHomeFeedEntity> clogged_drain;
  final List<ReportHomeFeedEntity> negligent_dumping;
}
