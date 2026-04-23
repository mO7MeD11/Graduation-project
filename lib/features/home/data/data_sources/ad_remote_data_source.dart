import '../../../../core/network/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/ad_model.dart';

class AdRemoteDataSource {
  final ApiService apiService;

  AdRemoteDataSource({required this.apiService});

  Future<List<AdModel>> getAds() async {
    final data = await apiService.get(ApiConstants.activeAds);
    return (data as List).map((json) => AdModel.fromJson(json)).toList();
  }
}