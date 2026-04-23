import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:graduationproject3/features/submit-complaint/presentation/manager/submit_complaint_cubit.dart';

import '../network/api_service.dart';
import '../../features/home/data/data_sources/ai_remote_data_source.dart';
import '../../features/home/data/data_sources/complaint_remote_data_source.dart';
import '../../features/home/data/data_sources/ad_remote_data_source.dart';

import '../../features/home/data/repositories/ai_repository_impl.dart';
import '../../features/home/data/repositories/complaint_repository_impl.dart';
import '../../features/home/data/repositories/ad_repository_impl.dart';

import '../../features/home/domain/repositories/ai_repository.dart';
import '../../features/home/domain/repositories/complaint_repository.dart';
import '../../features/home/domain/repositories/ad_repository.dart';

import '../../features/home/domain/usecases/get_suggestion_usecase.dart';
import '../../features/home/domain/usecases/autocomplete_usecase.dart';
import '../../features/home/domain/usecases/classification_usecase.dart';
import '../../features/home/domain/usecases/submit_complaint_usecase.dart';
import '../../features/auth/data/auth_repo.dart';

import '../constants/api_constants.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // 1. Dio Instances
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    )),
    instanceName: "complaintDio",
  );

  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: ApiConstants.aiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    )),
    instanceName: "aiDio",
  );

  // 2. Api Services
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<Dio>(instanceName: "complaintDio")),
    instanceName: "complaintService",
  );

  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<Dio>(instanceName: "aiDio")),
    instanceName: "aiService",
  );

  // 3. Data Sources
  sl.registerLazySingleton<ComplaintRemoteDataSource>(
    () => ComplaintRemoteDataSource(sl<ApiService>(instanceName: "complaintService")),
  );

  sl.registerLazySingleton<AiRemoteDataSource>(
    () => AiRemoteDataSource(sl<ApiService>(instanceName: "aiService")),
  );

  sl.registerLazySingleton<AdRemoteDataSource>(
    () => AdRemoteDataSource(apiService: sl<ApiService>(instanceName: "complaintService")),
  );

  // 4. Repositories
  sl.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(sl<ComplaintRemoteDataSource>()),
  );

  sl.registerLazySingleton<AiRepository>(
    () => AiRepositoryImpl(sl<AiRemoteDataSource>()),
  );

  sl.registerLazySingleton<AdRepository>(
    () => AdRepositoryImpl(sl<AdRemoteDataSource>()),
  );

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepo(sl<ApiService>(instanceName: "complaintService")),
  );

  // 5. Use Cases
  sl.registerLazySingleton(() => SubmitComplaintUseCase(sl<ComplaintRepository>()));
  sl.registerLazySingleton(() => GetSuggestionUseCase(sl<AiRepository>()));
  sl.registerLazySingleton(() => ClassifyIssueUseCase(sl<AiRepository>()));
  sl.registerLazySingleton(() => AutocompleteUseCase(sl<AiRepository>()));

  // 6. Cubits
  sl.registerFactory(() => SubmitComplaintCubit(
        submitUseCase: sl<SubmitComplaintUseCase>(),
        suggestionUseCase: sl<GetSuggestionUseCase>(),
        classifyUseCase: sl<ClassifyIssueUseCase>(),
      ));
}
