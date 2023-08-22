import 'package:chat_gpt/futures/core/hive/hive_box.dart';
import 'package:chat_gpt/futures/data/models/get_premium_model.dart';

class PremiumLocalDataSource {
  Future<void> create(GetPremiumModel model) async {
    await getPremiumBox.add(model);
  }

  Future<GetPremiumModel?> get() async {
    return getPremiumBox.getAt(0);
  }

  Future<void> delete() async {
    getPremiumBox.clear();
  }

  Future<void> update(GetPremiumModel model) async {
    getPremiumBox.putAt(0, model);
  }
}
