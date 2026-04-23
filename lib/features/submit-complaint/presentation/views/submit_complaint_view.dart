import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:graduationproject3/core/constants/app_colors.dart';
import 'package:graduationproject3/core/style/font_style.dart';
import 'package:graduationproject3/core/widgets/custom_button.dart';
import 'package:graduationproject3/core/widgets/custom_text_form_field.dart';
import 'package:graduationproject3/core/di/service_locator.dart';

import '../manager/submit_complaint_cubit.dart';
import '../manager/submit_complaint_state.dart';
import 'SuccessScreen.dart';
import 'map_selection_view.dart';

class SubmitComplaintScreen extends StatelessWidget {
  const SubmitComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SubmitComplaintCubit>(),
      child: const SubmitComplaintView(),
    );
  }
}

class SubmitComplaintView extends StatefulWidget {
  const SubmitComplaintView({super.key});

  @override
  State<SubmitComplaintView> createState() => _SubmitComplaintViewState();
}

class _SubmitComplaintViewState extends State<SubmitComplaintView> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _plateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high": return Colors.red;
      case "medium": return Colors.orange;
      case "low": return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubmitComplaintCubit>();

    return BlocListener<SubmitComplaintCubit, SubmitComplaintState>(
      listener: (context, state) {
        if (state is SubmitComplaintSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SuccessScreen()),
          );
        } else if (state is SubmitComplaintError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE8E8E8),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildImageSection(cubit),
                        const SizedBox(height: 15),
                        _buildPlateSection(),
                        const SizedBox(height: 15),
                        _buildDescriptionSection(cubit),
                        _buildAiAnalysisSection(),
                        const SizedBox(height: 15),
                        _buildLocationSection(cubit),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              // زر الإرسال ثابت في الأسفل مبيتحركش مع السكرول
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                child: _buildSubmitButton(cubit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
      height: 100, // صغرنا الارتفاع عشان الصفحة تبقى Fit
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          const Text('تقديم بلاغ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(SubmitComplaintCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('صورة لوحة المركبة', style: FontStyles.regular15.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BlocBuilder<SubmitComplaintCubit, SubmitComplaintState>(
          builder: (context, state) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => _showImageSourcePicker(context, cubit),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: cubit.selectedImage == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_upload_outlined, size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('اضغط لتحميل الصورة', style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              cubit.selectedImage!,
                              fit: BoxFit.contain, // 🔥 الصورة تظهر كاملة بدون قص (Fit)
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                  ),
                ),
                // زر الحذف (X) أسود خفيف وبدون خلفية
                if (cubit.selectedImage != null)
                  Positioned(
                    top: 5,
                    left: 5,
                    child: GestureDetector(
                      onTap: () => cubit.removeImage(),
                      child: const Icon(
                        Icons.close, 
                        color: Colors.black54, // أسود خفيف
                        size: 26,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showImageSourcePicker(BuildContext context, SubmitComplaintCubit cubit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('إرفاق صورة من', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _imagePickerItem(
                    icon: Icons.camera_alt_outlined,
                    label: 'الكاميرا',
                    onTap: () => _pickImage(ImageSource.camera, cubit),
                  ),
                  _imagePickerItem(
                    icon: Icons.image_outlined,
                    label: 'المعرض',
                    onTap: () => _pickImage(ImageSource.gallery, cubit),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePickerItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.amber[100], child: Icon(icon, color: Colors.amber[800], size: 30)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, SubmitComplaintCubit cubit) async {
    Navigator.pop(context); // إغلاق الـ BottomSheet
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      cubit.updateImage(File(pickedFile.path));
    }
  }

  Widget _buildPlateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('رقم لوحة المركبة (اختياري)', style: FontStyles.regular15.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextFormField(controller: _plateController, hintText: 'ا ب ج 1234'),
      ],
    );
  }

  Widget _buildDescriptionSection(SubmitComplaintCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('وصف الحادثة', style: FontStyles.regular15.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: _descController,
          minLines: 3,
          maxLines: null, 
          hintText: 'اكتب هنا وصف الحادثة',
          onChanged: (val) => cubit.onDescriptionChanged(val),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'الوصف مطلوب';
            if (value.length < 10) return 'الوصف قصير جدًا';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAiAnalysisSection() {
    return BlocBuilder<SubmitComplaintCubit, SubmitComplaintState>(
      builder: (context, state) {
        final cubit = context.read<SubmitComplaintCubit>();
        if (cubit.category.isEmpty && cubit.autoCompleteSuggestion.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            if (cubit.autoCompleteSuggestion.isNotEmpty)
              GestureDetector(
                onTap: () {
                  final newText = "${_descController.text} ${cubit.autoCompleteSuggestion}";
                  _descController.text = newText;
                  _descController.selection = TextSelection.collapsed(offset: newText.length);
                  cubit.autoCompleteSuggestion = '';
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(cubit.autoCompleteSuggestion),
                ),
              ),
            if (cubit.category.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getPriorityColor(cubit.priority).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: getPriorityColor(cubit.priority)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("التصنيف: ${cubit.category}"),
                    Row(
                      children: [
                        const Text("الأهمية: "),
                        Text(cubit.priority,
                            style: TextStyle(
                                color: getPriorityColor(cubit.priority), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLocationSection(SubmitComplaintCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الموقع', style: FontStyles.regular15.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BlocBuilder<SubmitComplaintCubit, SubmitComplaintState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EgyptMapScreen()),
                );
                if (result != null) {
                  final lat = result["lat"];
                  final lng = result["lng"];
                  final name = result["name"];
                  cubit.updateLocation(LatLng(lat, lng), name ?? "موقع محدد");
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined, 
                      color: Colors.amber, 
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      cubit.locationText,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(SubmitComplaintCubit cubit) {
    return BlocBuilder<SubmitComplaintCubit, SubmitComplaintState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 55,
          child: CustomButton(
            text: state is SubmitComplaintLoading ? 'جاري الإرسال...' : 'إرسال',
            onTap: state is SubmitComplaintLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      cubit.submitComplaint(
                        plateNumber: _plateController.text,
                        description: _descController.text,
                      );
                    }
                  },
          ),
        );
      },
    );
  }
}
