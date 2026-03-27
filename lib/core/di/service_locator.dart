import 'package:get_it/get_it.dart';

import '../../features/home/data/data_sources/ai_remote_data_source.dart';
import '../../features/home/data/data_sources/complaint_remote_data_source.dart';
import '../../features/home/data/repositories/ai_repository_impl.dart';
import '../../features/home/data/repositories/complaint_repository_impl.dart';
import '../../features/home/domain/repositories/ai_repository.dart';
import '../../features/home/domain/repositories/complaint_repository.dart';
import '../../features/home/domain/usecases/autocomplete_usecase.dart';
import '../../features/home/domain/usecases/classification_usecase.dart';
import '../../features/home/domain/usecases/get_suggestion_usecase.dart';
import '../../features/home/domain/usecases/submit_complaint_usecase.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void setupServiceLocator() {

  // 📡 Data Source
  sl.registerLazySingleton<Dio>(
        () => Dio(),
  );

  sl.registerLazySingleton<ComplaintRemoteDataSource>(
        () => ComplaintRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<ComplaintRepository>(
        () => ComplaintRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetSuggestionUseCase>(
        () => GetSuggestionUseCase(sl()),
  );

  sl.registerLazySingleton<SubmitComplaintUseCase>(
        () => SubmitComplaintUseCase(sl()),

  );
  sl.registerLazySingleton<AiRemoteDataSource>(
        () => AiRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<AiRepository>(
        () => AiRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AutocompleteUseCase>(
        () => AutocompleteUseCase(sl()),
  );

  sl.registerLazySingleton<ClassifyIssueUseCase>(
        () => ClassifyIssueUseCase(sl()),
  );
}
