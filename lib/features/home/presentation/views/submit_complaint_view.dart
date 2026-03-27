import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:graduationproject/core/theme/app_colors.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/core/widgets/custom_button.dart';
import 'package:graduationproject/core/widgets/custom_text_form_field.dart';

import 'map_selection_view.dart';
import 'successscreen.dart';

//  GetIt
import 'package:graduationproject/core/di/service_locator.dart';

// UseCases
import '../../domain/usecases/submit_complaint_usecase.dart';
import '../../domain/usecases/get_suggestion_usecase.dart';

class SubmitComplaintScreen extends StatefulWidget {
  const SubmitComplaintScreen({super.key});

  @override
  State<SubmitComplaintScreen> createState() =>
      _SubmitComplaintScreenState();
}

class _SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final _plateController = TextEditingController();
  final _descController = TextEditingController();

  File? _selectedImage;
  LatLng? _selectedLatLng;

  String _locationText = 'اضغط لتحديد الموقع';
  String _autoCompleteSuggestion = '';
  bool _isLoading = false;

  Timer? _debounce;

  //  GetIt UseCases
  final SubmitComplaintUseCase submitUseCase = sl<SubmitComplaintUseCase>();
  final GetSuggestionUseCase suggestionUseCase = sl<GetSuggestionUseCase>();

  @override
  void initState() {
    super.initState();

    _descController.addListener(() {
      _onDescriptionChanged(_descController.text);
    });
  }

  //  Image Picker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  //  Open Map
  Future<void> _openMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EgyptMapScreen()),
    );

    if (result != null) {
      final lat = result["lat"];
      final lng = result["lng"];
      final name = result["name"] ??
          "${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}";

      setState(() {
        _selectedLatLng = LatLng(lat, lng);
        _locationText = '📍 $name';
      });
    }
  }

  //  AI Suggestion
  void _onDescriptionChanged(String value) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () async {
      if (value.trim().isEmpty) {
        setState(() => _autoCompleteSuggestion = '');
        return;
      }

      try {
        final suggestions =
        await sl<GetSuggestionUseCase>().call(value);

        if (suggestions.isNotEmpty) {
          setState(() {
            _autoCompleteSuggestion = suggestions[0];
          });
        } else {
          setState(() => _autoCompleteSuggestion = '');
        }
      } catch (e) {
        setState(() => _autoCompleteSuggestion = '');
      }
    });
  }

  //  Submit Complaint
  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب إرفاق صورة لوحة المركبة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى تحديد الموقع من الخريطة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await submitUseCase.call(
        text: _descController.text.trim(),
        lat: _selectedLatLng!.latitude,
        lng: _selectedLatLng!.longitude,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccessScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _plateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Column(
        children: [
          //  Header
          Container(
            padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
            height: 140,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'تقديم بلاغ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          //  Form
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //  Image
                    Text(
                      'صورة لوحة المركبة',
                      style: FontStyles.regular15
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: _selectedImage == null
                              ? const Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_upload_outlined,
                                  size: 50),
                              SizedBox(height: 8),
                              Text('اضغط لتحميل الصورة'),
                            ],
                          )
                              : ClipRRect(
                            borderRadius:
                            BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    //  Plate
                    Text(
                      'رقم لوحة المركبة (اختياري)',
                      style: FontStyles.regular15
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    CustomTextFormField(
                      controller: _plateController,
                      hintText: 'ا ب ج 1234',
                    ),

                    const SizedBox(height: 18),

                    //  Description
                    Text(
                      'وصف الحادثة',
                      style: FontStyles.regular15
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    CustomTextFormField(
                      controller: _descController,
                      maxLines: 4,
                      hintText: 'اكتب هنا وصف الحادثة',
                      validator: (v) =>
                      v == null || v.length < 10
                          ? 'الوصف قصير جدًا'
                          : null,
                    ),

                    //  Suggestion
                    if (_autoCompleteSuggestion.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _descController.text =
                                _autoCompleteSuggestion;
                            _autoCompleteSuggestion = '';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius:
                            BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(_autoCompleteSuggestion),
                        ),
                      ),

                    const SizedBox(height: 18),

                    //  Location
                    Text(
                      'الموقع',
                      style: FontStyles.regular15
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: _openMap,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            _selectedLatLng == null
                                ? 'تحديد الموقع'
                                : _locationText,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    //  Submit
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: CustomButton(
                        text: _isLoading
                            ? 'جاري الإرسال...'
                            : 'إرسال',
                        onTap: () {
                          if (!_isLoading) {
                            _submitComplaint();
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}