import '../../domain/repositories/ad_repository.dart';
import '../data_sources/ad_remote_data_source.dart';
import '../models/ad_model.dart';

class AdRepositoryImpl implements AdRepository {
  final AdRemoteDataSource remoteDataSource;

  AdRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AdModel>> getAds() async {
    try {
      return await remoteDataSource.getAds();
    } catch (e) {
      throw Exception("Failed to load ads: $e");
    }
  }
}