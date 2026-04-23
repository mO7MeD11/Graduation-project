import '../../data/models/ad_model.dart';

abstract class AdRepository {
  Future<List<AdModel>> getAds();
}