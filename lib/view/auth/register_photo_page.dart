import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/vm/auth/register_photo_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPhotoPage extends StatefulWidget {
  const RegisterPhotoPage({super.key});

  @override
  State<RegisterPhotoPage> createState() => _RegisterPhotoPageState();
}

class _RegisterPhotoPageState extends State<RegisterPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterPhotoViewModel(),
      child: Consumer<RegisterPhotoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xffF6F9FF),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xff1F59DF),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "صورة الملف الشخصي",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "أضف صورتك الشخصية (اختياري)",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () => viewModel.pickFile(context),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade50,
                          ),
                          child:
                              viewModel.selectedImage == null
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image_outlined,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text("اسحب وأفلت الصورة هنا"),
                                      const Text("أو"),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed:
                                            () => viewModel.pickFile(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xffF6F9FF,
                                          ),
                                          foregroundColor: const Color(
                                            0xff1F59DF,
                                          ),
                                        ),
                                        child: const Text("اختر صورة"),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "(الحد الأقصى 5MB - JPG, PNG, GIF)",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                  : Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          viewModel.selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: viewModel.removeImage,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black54,
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        text: 'متابعة',
                        icon: const Icon(Icons.arrow_back),
                        color: const Color(0xff1F59DF),
                        textColor: Colors.white,
                        onPressed: () => viewModel.onContinuePressed(context),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'تخطي هذه الخطوة',
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.grey.shade200,
                        textColor: Colors.black,
                        onPressed: () => viewModel.onSkipPressed(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
