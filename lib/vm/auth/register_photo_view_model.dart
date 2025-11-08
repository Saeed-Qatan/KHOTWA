import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khotwa/view/auth/register_cv_skills_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/model/auth/register_data_model.dart';

class RegisterPhotoViewModel with ChangeNotifier {
  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  Future<bool?> _showPermissionRationalDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('الإذن مطلوب'),
        content: const Text(
          'لقد قمت برفض الإذن سابقاً. نحتاج إليه لاختيار صورة للملف الشخصي. هل ترغب بفتح الإعدادات لتفعيله؟',
        ),
        actions: [
          TextButton(
            child: const Text('لاحقاً'),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: const Text('نعم، فتح الإعدادات'),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
  }

  Future<void> _showSettingsDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('الصلاحية مرفوضة نهائياً'),
        content: const Text(
          'لقد قمت برفض إذن الوصول للصور. لتمكين هذه الميزة، يرجى الذهاب إلى إعدادات التطبيق وتفعيل الإذن يدوياً.',
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

  Future<bool> _requestStoragePermission(BuildContext context) async {
    if (!Platform.isAndroid) {
      final photos = await Permission.photos.request();
      return photos.isGranted;
    }

    // Android 13+ (API 33)
    if (Platform.isAndroid && (await _getAndroidVersion()) >= 33) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
      if (photos.isPermanentlyDenied) {
        await _showSettingsDialog(context);
        return false;
      }
      return false;
    }

    //Android 11-12 (API 30-32)
    if ((await _getAndroidVersion()) >= 30) {
      final manage = await Permission.manageExternalStorage.request();
      if (manage.isGranted) return true;
      if (manage.isPermanentlyDenied) {
        await _showSettingsDialog(context);
        return false;
      }
      return false;
    }

    // Android 10
    final storage = await Permission.storage.request();
    if (storage.isGranted) return true;
    if (storage.isPermanentlyDenied) {
      await _showSettingsDialog(context);
      return false;
    }

    return false;
  }

  Future<int> _getAndroidVersion() async {
    try {
      final version = await Process.run('getprop', ['ro.build.version.sdk']);
      return int.parse(version.stdout.toString().trim());
    } catch (e) {
      return 33;
    }
  }

  Future<void> pickFile(BuildContext context) async {
    try {
      bool permissionGranted = await _requestStoragePermission(context);
      if (!permissionGranted) {
        debugPrint("❌ الصلاحية مرفوضة");
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: false,
      );

      if (result == null || result.files.isEmpty) {
        debugPrint("🚫 لم يتم اختيار أي ملف");
        return;
      }

      final path = result.files.single.path;
      if (path == null) {
        debugPrint("⚠️ لم يتم العثور على مسار الملف");
        return;
      }

      _selectedImage = File(path);
      debugPrint("✅ تم اختيار الملف بنجاح: $path");

      notifyListeners();
    } catch (e, stack) {
      debugPrint("❗ خطأ أثناء اختيار الملف: $e");
      debugPrint("Stack: $stack");
    }
  }

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }

  void _updateSharedModel(BuildContext context) {
    final dataModel = Provider.of<RegisterDataModel>(context, listen: false);

    dataModel.profileImage = (_selectedImage);
  }

  void onContinuePressed(BuildContext context) {
    final registerData = Provider.of<RegisterDataModel>(context, listen: false);
    _updateSharedModel(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (newContext) => ChangeNotifierProvider.value(
          value: registerData,
          child: const RegisterCVPage(),
        ),
      ),
    );
  }

  void onSkipPressed(BuildContext context) {
    final registerData = Provider.of<RegisterDataModel>(context, listen: false);
    _updateSharedModel(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (newContext) => ChangeNotifierProvider.value(
          value: registerData,
          child: const RegisterCVPage(),
        ),
      ),
    );
  }
}
