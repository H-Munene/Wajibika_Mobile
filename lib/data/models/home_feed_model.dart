import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_feed_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeFeedModel extends HomeFeedEntity {
  HomeFeedModel({
    required super.clogged_drain,
    required super.negligent_dumping,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeFeedModelToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return 'HomeFeed: cloggedDrain[${clogged_drain}] negligentDumping [${negligent_dumping}]';
  }
}
