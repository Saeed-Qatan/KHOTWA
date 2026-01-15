// lib/view/forget_page.dart
import 'package:flutter/material.dart';
import 'package:khotwa/vm/auth/forget_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../widgets/DisplayBox_widget.dart';
import '../../core/theme/app_theme.dart';
import '../../core/navigations/navigations.dart';
import 'login_page.dart';
import '../../main.dart'; // for snackbarService

class ForgetPage extends StatelessWidget {
  const ForgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgetViewModel(),
      child: Consumer<ForgetViewModel>(
        builder: (context, vm, child) {
          // Listen to state changes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vm.state == ForgetState.success) {
              snackbarService.showSnackBar(
                'تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني',
                AppTheme.successColor,
              );
              AppNavigation.pushReplacment(context, const LoginPage());
            }
            if (vm.state == ForgetState.error && vm.error != null) {
              snackbarService.showSnackBar(
                vm.error!,
                AppTheme.lightTheme.colorScheme.error,
              );
            }
          });

          return Scaffold(
            backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DisplayBoxWidget(
                  icon: Icons.lock_reset_rounded,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "أدخل بريدك الإلكتروني لاستعادة كلمة المرور",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: vm.emailController,
                        hintText: 'ادخل بريدك الالكتروني',
                        obscuretext: false,
                        text: 'البريد الالكتروني',
                        suffixIcon: const Icon(Icons.email_outlined),
                        prefixIcon: null,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: vm.isLoading ? 'جارٍ...' : 'إرسال رابط الاستعادة',
                        icon: const Icon(Icons.send_rounded),
                        color: vm.canSubmit
                            ? const Color(0xff1F59DF)
                            : Colors.grey.shade400,
                        textColor: Colors.white,
                        onPressed: vm.canSubmit
                            ? () {
                                FocusScope.of(context).unfocus();
                                vm.submit();
                              }
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          AppNavigation.push(context, const LoginPage());
                        },
                        child: Text(
                          "العودة لتسجيل الدخول",
                          style: TextStyle(
                            color: AppTheme.lightTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
