import 'package:hive_flutter/hive_flutter.dart';

part 'get_premium_model.g.dart';

@HiveType(typeId: 2)
class GetPremiumModel {
  @HiveField(0)
  bool? isPremium;
  GetPremiumModel({required this.isPremium});
}
