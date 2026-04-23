import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduationproject3/features/home/domain/entities/complaint.dart';
import 'package:graduationproject3/features/home/domain/usecases/classification_usecase.dart';
import 'package:graduationproject3/features/home/domain/usecases/get_suggestion_usecase.dart';
import 'package:graduationproject3/features/home/domain/usecases/submit_complaint_usecase.dart';


import 'submit_complaint_state.dart';

class SubmitComplaintCubit extends Cubit<SubmitComplaintState> {
  final SubmitComplaintUseCase submitUseCase;
  final GetSuggestionUseCase suggestionUseCase;
  final ClassifyIssueUseCase classifyUseCase;

  SubmitComplaintCubit({
    required this.submitUseCase,
    required this.suggestionUseCase,
    required this.classifyUseCase,
  }) : super(SubmitComplaintInitial());

  File? selectedImage;
  LatLng? selectedLatLng;
  String locationText = 'اضغط لتحديد الموقع';
  String autoCompleteSuggestion = '';
  String category = '';
  String priority = '';
  Timer? _debounce;

  void onDescriptionChanged(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty || value.length < 3) {
      autoCompleteSuggestion = '';
      category = '';
      priority = '';
      emit(SubmitComplaintInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 600), () async {
      try {
        final suggestions = await suggestionUseCase(value);
        final analysis = await classifyUseCase(value);

        autoCompleteSuggestion = suggestions.isNotEmpty ? suggestions[0] : '';
        category = analysis.category;
        priority = analysis.priority;

        emit(AiAnalysisSuccess(
          suggestion: autoCompleteSuggestion,
          category: category,
          priority: priority,
        ));
      } catch (e) {
        emit(AiAnalysisError(message: e.toString()));
      }
    });
  }

  void updateImage(File image) {
    selectedImage = image;
    emit(SubmitComplaintInitial());
  }

  void removeImage() {
    selectedImage = null;
    emit(SubmitComplaintInitial());
  }

  void updateLocation(LatLng latLng, String name) {
    selectedLatLng = latLng;
    locationText = '📍 $name';
    emit(SubmitComplaintInitial());
  }

  Future<void> submitComplaint({
    required String plateNumber,
    required String description,
  }) async {
    if (selectedImage == null) {
      emit(SubmitComplaintError(message: 'يجب إرفاق صورة لوحة المركبة'));
      return;
    }
    if (selectedLatLng == null) {
      emit(SubmitComplaintError(message: 'يرجى تحديد الموقع من الخريطة'));
      return;
    }

    emit(SubmitComplaintLoading());

    try {
      await submitUseCase(
        Complaint(
          title: plateNumber.isEmpty ? "Complaint" : plateNumber,
          description: description.trim(),
          category: category.isEmpty ? "General" : category,
          lat: selectedLatLng!.latitude,
          lng: selectedLatLng!.longitude,
          image: selectedImage,
        ),
      );
      emit(SubmitComplaintSuccess());
    } catch (e) {
      emit(SubmitComplaintError(message: 'حدث خطأ أثناء الإرسال، حاول مرة أخرى'));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
