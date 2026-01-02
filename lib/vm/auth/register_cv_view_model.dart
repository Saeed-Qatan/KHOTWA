import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/model/auth/register_data_model.dart';
import 'package:khotwa/view/home_page.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RegisterCVViewModel with ChangeNotifier {
  final TextEditingController skillController = TextEditingController();
  bool _isLoading = false;
  String _cvFileName = '';

  final List<String> suggestedSkills = [
    'Node.js',
    'React',
    'Javascript',
    'Python',
    'HTML/CSS',
    'إدارة المشاريع',
    'التسويق الرقمي',
    'التصميم الجرافيكي',
    'تحليل البيانات',
    'خدمة العملاء',
    'المحاسبة',
    'إدارة الوقت',
  ];

  final List<String> fieldsOfInterest = [
    'هندسة البرمجيات',
    'التسويق والمبيعات',
    'علم البيانات',
    'التصميم الجرافيكي',
    'الرعاية الصحية',
    'الهندسة',
    'التمويل والمحاسبة',
  ];

  bool get isLoading => _isLoading;
  String get cvFileName => _cvFileName;

  /// ✅ يطلب الصلاحيات حسب نسخة أندرويد (يدعم Android 6 إلى 14)
  Future<bool> _requestStoragePermission(BuildContext context) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted ||
          await Permission.storage.isGranted ||
          await Permission.photos.isGranted ||
          await Permission.mediaLibrary.isGranted) {
        return true;
      }

      // طلب الصلاحيات المناسبة حسب الإصدار
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.request().isGranted ||
            await Permission.storage.request().isGranted ||
            await Permission.photos.request().isGranted ||
            await Permission.mediaLibrary.request().isGranted) {
          return true;
        }
      }
    } else {
      // iOS
      if (await Permission.photos.isGranted) return true;
      if (await Permission.photos.request().isGranted) return true;
    }

    // لو تم الرفض بشكل دائم
    if (await Permission.storage.isPermanentlyDenied ||
        await Permission.manageExternalStorage.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('الصلاحية مرفوضة نهائياً'),
            content: const Text(
              'يرجى تفعيل إذن الوصول للملفات من إعدادات التطبيق.',
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                child: const Text('فتح الإعدادات'),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
      return false;
    }

    return false;
  }

  /// 📄 اختيار ملف PDF (أو DOC)
  Future<void> pickCVFile(BuildContext context) async {
    bool permissionGranted = await _requestStoragePermission(context);
    if (!permissionGranted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم رفض إذن الوصول للملفات. يرجى تفعيل الصلاحية.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final dataModel = Provider.of<RegisterDataModel>(context, listen: false);
      dataModel.setCVFile(File(result.files.single.path!));

      _cvFileName = result.files.single.name;
      notifyListeners();
    }
  }

  void addSkillFromTextField(BuildContext context) {
    if (skillController.text.trim().isNotEmpty) {
      final dataModel = Provider.of<RegisterDataModel>(context, listen: false);
      if (!dataModel.skills.contains(skillController.text.trim())) {
        dataModel.addSkill(skillController.text.trim());
      }
      skillController.clear();
    }
  }

  void addSuggestedSkill(BuildContext context, String skill) {
    final dataModel = Provider.of<RegisterDataModel>(context, listen: false);
    if (!dataModel.skills.contains(skill)) {
      dataModel.addSkill(skill);
    }
  }

  void removeSkill(BuildContext context, String skill) {
    final dataModel = Provider.of<RegisterDataModel>(context, listen: false);
    dataModel.removeSkill(skill);
  }

  void selectField(BuildContext context, String? newValue) {
    if (newValue == null) return;
    final dataModel = Provider.of<RegisterDataModel>(context, listen: false);
    dataModel.setFieldOfInterest(newValue);
  }

  Future<void> finishRegistration(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final dataModel = Provider.of<RegisterDataModel>(context, listen: false);

    try {
      print("===== بيانات التسجيل النهائية =====");
      print("الاسم: ${dataModel.firstName} ${dataModel.familyName}");
      print("الصورة: ${dataModel.profileImage?.path}");
      print("السيرة الذاتية: ${dataModel.cvFile?.path}");
      print("المهارات: ${dataModel.skills}");
      print("المجال: ${dataModel.fieldOfInterest}");
      print("===================================");

      await Future.delayed(const Duration(seconds: 2));

      _isLoading = true;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '✅ تم إكمال التسجيل بنجاح! جاري الانتقال إلى الصفحة الرئيسية...',
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print("Error in finishRegistration: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    skillController.dispose();
    super.dispose();
  }
}
