import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/core/them/app_theme.dart';
import 'package:khotwa/view/auth/register_info_page.dart';
import 'package:khotwa/widgets/DisplayBox_widget.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/components/custom_text_field.dart';
import 'package:khotwa/view/auth/forget_page.dart';
import 'package:khotwa/view/home_page.dart';
import 'package:khotwa/vm/auth/login_view_model.dart';
import 'package:khotwa/main.dart';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});
  

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
      
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xffF6F9FF),
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

                      // البريد الالكتروني
                      CustomTextField(
                        controller: viewModel.emailController,
                        hintText: 'ادخل بريدك الالكتروني',
                        obscuretext: false,
                        text: 'البريد الالكتروني',
                        suffixIcon: const Icon(Icons.email_outlined),
                        prefixIcon: null,
                        validator: viewModel.emailValidator,
                      ),
                      const SizedBox(height: 10),

                      // كلمة المرور
                      CustomTextField(
                        text: 'كلمة المرور',
                        controller: viewModel.passwordController,
                        hintText: 'كلمة المرور',
                        obscuretext: viewModel.obscurePassword,
                        prefixIcon: IconButton(
                          icon: Icon(
                            viewModel.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: viewModel.togglePasswordVisibility,
                        ),
                        suffixIcon: const Icon(Icons.lock_outline),
                        validator: viewModel.passwordValidator,
                      ),
                      const SizedBox(height: 5),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("تذكرني"),
                          Checkbox(
                            activeColor: Colors.blueAccent,
                            checkColor: Colors.white,
                            splashRadius: 4,
                            value: viewModel.loginData.rememberMe,
                            onChanged: (value) {
                              viewModel.toggleRememberMe(value ?? false);
                            },
                          ),
                          const SizedBox(width: 50),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'هل نسيت كلمة المرور؟ ',
                                  style:  TextStyle(
                                    color: AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ForgetPage(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // زر تسجيل الدخول
                      CustomButton(
                        text: viewModel.isLoaded ? 'جارٍ...' : 'تسجيل الدخول',
                        icon: const Icon(Icons.login_rounded),
                        color: viewModel.canLogin
                            ? const Color(0xff1F59DF)
                            : Colors.grey.shade400,
                        textColor: Colors.white,
                        // enable button only when canLogin is true and not loading
                        onPressed: (viewModel.canLogin && !viewModel.isLoaded)
                            ? () async {
                                // hide keyboard
                                FocusScope.of(context).unfocus();

                                final bool success = await viewModel.login();

                                if (!context.mounted) return;

                                if (success) {
                                  snackbarService.showSnackBar(
                                    'تسجيل الدخول ناجح',
                                    Colors.green,
                                  );

                                  // short delay for snack bar to appear
                                  await Future.delayed(
                                    const Duration(milliseconds: 400),
                                  );

                                  if (!context.mounted) return;

                                  AppNavigation.pushReplacment(
                                    context,
                                    HomePage(),
                                  );
                                } else {
                                  snackbarService.showSnackBar(
                                    Text(
                                      viewModel.errorMessage.isNotEmpty
                                          ? viewModel.errorMessage
                                          : 'Login failed',
                                    ),
                                    Colors.red,
                                  );
                                }
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

                      CustomButton(
                        text: 'تسجيل الدخول بجوجل ',
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {},
                      ),
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
                              style: const TextStyle(
                                color: Color(0xff1F59DF),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AppNavigation.push(
                                    context,
                                    const RegisterPage(),
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
