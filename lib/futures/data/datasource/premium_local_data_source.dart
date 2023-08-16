import 'package:chat_gpt/futures/data/models/get_premium_model.dart';
import 'package:hive/hive.dart';

class PremiumLocalDataSource {
  Future<void> create(GetPremiumModel model) async {
    var box = await Hive.openBox<GetPremiumModel>("premium_model");
    await box.add( model);
  }

  Future<GetPremiumModel?> get() async {
    var box = await Hive.openBox<GetPremiumModel>("premium_model");
    return box.getAt(0);
  }

  Future<void> delete() async {
    var box = await Hive.openBox<GetPremiumModel>("premium_model");
    box.clear();
  }

  Future<void> update(GetPremiumModel model) async {
    var box = await Hive.openBox<GetPremiumModel>("premium_model");
    box.putAt(0, model);
  }
}
