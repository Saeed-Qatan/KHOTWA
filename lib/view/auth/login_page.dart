import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../core/navigations/navigations.dart';
import '../../core/theme/app_theme.dart';
import '../../main.dart'; // for snackbarService
import '../../view/auth/forget_page.dart';
import '../../view/auth/register_info_page.dart';
import '../../view/main_view.dart';
import '../../vm/auth/login_view_model.dart';
import '../../widgets/DisplayBox_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, child) {
          // Listen to state changes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (vm.state == LoginState.success) {
              snackbarService.showSnackBar(
                'تسجيل الدخول ناجح',
                AppTheme.successColor,
              );
              // Wait briefly for snackbar then navigate
              AppNavigation.pushReplacment(context, MainView());
            }
            if (vm.state == LoginState.error && vm.errorMessage != null) {
              snackbarService.showSnackBar(
                vm.errorMessage!,
                AppTheme.lightTheme.colorScheme.error,
              );
            }
          });

          return Scaffold(
            backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DisplayBoxWidget(
                  icon: Icons.person_outline_rounded,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "مرحبا بعودتك",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "سجل دخولك للوصول الى حسابك",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email
                      CustomTextField(
                        controller: vm.emailController,
                        hintText: 'ادخل بريدك الالكتروني',
                        obscuretext: false,
                        text: 'البريد الالكتروني',
                        suffixIcon: const Icon(Icons.email_outlined),
                        prefixIcon: null,
                        validator: vm.emailValidator,
                      ),
                      const SizedBox(height: 10),

                      // Password
                      CustomTextField(
                        text: 'كلمة المرور',
                        controller: vm.passwordController,
                        hintText: 'كلمة المرور',
                        obscuretext: vm.obscurePassword,
                        prefixIcon: IconButton(
                          icon: Icon(
                            vm.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: vm.togglePasswordVisibility,
                        ),
                        suffixIcon: const Icon(Icons.lock_outline),
                        validator: vm.passwordValidator,
                      ),
                      const SizedBox(height: 5),

                      // Options Row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("تذكرني"),
                          Checkbox(
                            activeColor: Colors.blueAccent,
                            checkColor: Colors.white,
                            splashRadius: 4,
                            value: vm.loginData.rememberMe,
                            onChanged: (value) {
                              vm.toggleRememberMe(value ?? false);
                            },
                          ),
                          const SizedBox(width: 50),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'هل نسيت كلمة المرور؟ ',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppNavigation.push(
                                        context,
                                        const ForgetPage(),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Login Button
                      CustomButton(
                        text: vm.isLoading ? 'جارٍ...' : 'تسجيل الدخول',
                        icon: const Icon(Icons.login_rounded),
                        color: vm.canLogin
                            ? const Color(0xff1F59DF)
                            : Colors.grey.shade400,
                        textColor: Colors.white,
                        onPressed: vm.canLogin
                            ? () {
                                FocusScope.of(context).unfocus();
                                vm.submit();
                              }
                            : null,
                      ),

                      const SizedBox(height: 15),

                      // Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                endIndent: 20,
                                indent: 10,
                              ),
                            ),
                            Text(
                              'او',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                endIndent: 10,
                                indent: 20,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Google Login
                      CustomButton(
                        text: vm.isLoading ? 'جارٍ...' : 'تسجيل الدخول بجوجل ',
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: vm.isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                vm.loginWithGoogle();
                              },
                      ),

                      // Facebook Login (Placeholder)
                      CustomButton(
                        text: 'تسجيل الدخول بفيسبوك ',
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {},
                      ),

                      // Register Link
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'ليس لديك حساب؟ ',
                              style: TextStyle(color: Colors.black),
                            ),
                            const TextSpan(text: "  "),
                            TextSpan(
                              text: "إنشاء حساب جديد",
                              style: TextStyle(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AppNavigation.pushReplacment(
                                    context,
                                    RegisterPage(),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
