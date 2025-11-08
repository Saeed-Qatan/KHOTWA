import 'package:flutter/material.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/model/register_data_model.dart';
import 'package:khotwa/vm/register_cv_view_model.dart';
import 'package:provider/provider.dart';

class RegisterCVPage extends StatefulWidget {
  const RegisterCVPage({super.key});

  @override
  State<RegisterCVPage> createState() => _RegisterCVPageState();
}

class _RegisterCVPageState extends State<RegisterCVPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterCVViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F9FF),
        body: Center(
          child: SingleChildScrollView(
            child: Consumer<RegisterDataModel>(
              builder: (context, dataModel, child) {
                final viewModel = Provider.of<RegisterCVViewModel>(
                  context,
                  listen: false,
                );

                final isFormComplete =
                    dataModel.cvFile != null &&
                    dataModel.fieldOfInterest != null &&
                    dataModel.skills.isNotEmpty;

                final availableSuggestedSkills = viewModel.suggestedSkills
                    .where((skill) => !dataModel.skills.contains(skill))
                    .toList();

                return Container(
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
                      const SizedBox(height: 40),
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
                          Icons.file_present_rounded,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "السيرة الذاتية والمهارات",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "أكمل ملفك الشخصي لتحصل على أفضل الفرص",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "رفع السيرة الذاتية",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => viewModel.pickCVFile(context),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade50,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.upload_file_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                              if (dataModel.cvFile != null)
                                Consumer<RegisterCVViewModel>(
                                  builder: (context, cvViewModel, child) =>
                                      Text(
                                        cvViewModel.cvFileName,
                                        style: const TextStyle(
                                          color: Color(0xff1F59DF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                )
                              else
                                ElevatedButton(
                                  onPressed: () =>
                                      viewModel.pickCVFile(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffF6F9FF),
                                    foregroundColor: const Color(0xff1F59DF),
                                  ),
                                  child: const Text("اختر ملف السيرة الذاتية"),
                                ),
                              const SizedBox(height: 8),
                              const Text(
                                "(الحد الأقصى 10MB - PDF, DOC, DOCX)",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "المهارات",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff1F59DF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () =>
                                  viewModel.addSkillFromTextField(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: viewModel.skillController,
                              decoration: InputDecoration(
                                hintText: "أضف مهارة جديدة...",
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              onSubmitted: (value) =>
                                  viewModel.addSkillFromTextField(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          alignment: WrapAlignment.start,
                          children: dataModel.skills
                              .map(
                                (skill) => Chip(
                                  label: Text(skill),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () =>
                                      viewModel.removeSkill(context, skill),
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "مهارات مقترحة:",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          alignment: WrapAlignment.start,
                          children: availableSuggestedSkills
                              .map(
                                (skill) => ActionChip(
                                  label: Text(skill),
                                  backgroundColor: Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    color: Colors.grey.shade800,
                                  ),
                                  side: BorderSide.none,
                                  onPressed: () => viewModel.addSuggestedSkill(
                                    context,
                                    skill,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 25),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "المجال المهتم به",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: dataModel.fieldOfInterest,
                        hint: const Text('اختر المجال المهتم به'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        items: viewModel.fieldsOfInterest.map((String field) {
                          return DropdownMenuItem<String>(
                            value: field,
                            child: Text(field),
                          );
                        }).toList(),
                        onChanged: (newValue) =>
                            viewModel.selectField(context, newValue),
                      ),
                      const SizedBox(height: 30),

                      Consumer<RegisterCVViewModel>(
                        builder: (context, cvViewModel, child) {
                          return cvViewModel.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  text: 'إنهاء التسجيل',
                                  color: isFormComplete
                                      ? const Color(0xff1F59DF)
                                      : Colors.grey.shade400,
                                  textColor: Colors.white,
                                  onPressed: isFormComplete
                                      ? () => cvViewModel.finishRegistration(
                                          context,
                                        )
                                      : null,
                                );
                        },
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xff1F59DF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
