import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/core/theme/app_theme.dart';
import 'package:khotwa/view/auth/register_info_page.dart';
import 'package:khotwa/vm/auth/register_Info_view_model.dart';
import 'package:khotwa/widgets/DisplayBox_widget.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/components/custom_text_field.dart';
import 'package:khotwa/view/auth/forget_page.dart';
import 'package:khotwa/view/home_page.dart';
import 'package:khotwa/vm/auth/login_view_model.dart';
import 'package:khotwa/main.dart';

class RegisterInfoPage1 extends StatefulWidget {
  const RegisterInfoPage1({super.key});

  @override
  State<RegisterInfoPage1> createState() => _RegisterInfoPage1State();
}

class _RegisterInfoPage1State extends State<RegisterInfoPage1> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterInfoViewModel(),
      child: Consumer<RegisterInfoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xffF6F9FF),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DisplayBoxWidget(
                  icon: FontAwesomeIcons.userPlus,
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // البريد الالكتروني
                        CustomTextField(
                          controller: viewModel.firstName_controller,
                          hintText: '  علي',
                          obscuretext: false,
                          text: ' الاسم الاول',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator: (value) =>
                              viewModel.notEmptyValidator(value, "الاسم الأول"),
                        ),
                        const SizedBox(height: 10),

                        // كلمة المرور
                        CustomTextField(
                          controller: viewModel.firstName_controller,
                          hintText: '   ناصر ',
                          obscuretext: false,
                          text: ' اسم الأب',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator: (value) =>
                              viewModel.notEmptyValidator(value, "اسم الأب"),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: viewModel.firstName_controller,
                          hintText: '   بامخشب  ',
                          obscuretext: false,
                          text: ' اسم العائلة ',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator: (value) =>
                              viewModel.notEmptyValidator(value, "اسم العائلة"),
                        ),
                        // زر تسجيل الدخول
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: viewModel.email_controller,
                          hintText: 'ali@gmail.com',
                          obscuretext: false,
                          text: 'البريد الإلكتروني',
                          suffixIcon: Icon(Icons.email_outlined),
                          prefixIcon: null,
                          validator: viewModel.emailValidator,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: viewModel.phone_controller,
                          hintText: '+967774165326',
                          obscuretext: false,
                          text: 'رقم الهاتف',
                          suffixIcon: Icon(Icons.phone_outlined),
                          prefixIcon: null,
                          validator: (value) =>
                              viewModel.notEmptyValidator(value, "رقم الهاتف"),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          text: 'كلمة المرور',
                          controller: viewModel.password_controller,
                          hintText: 'كلمة المرور',
                          prefixIcon: IconButton(
                            icon: Icon(
                              viewModel.obscure_password
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: viewModel.togglePasswordVisibility,
                          ),
                          obscuretext: viewModel.obscure_password,
                          suffixIcon: const Icon(Icons.lock_outline),
                          validator: viewModel.passwordValidator,
                        ),
                        CustomTextField(
                          controller: viewModel.confirm_password_controller,
                          hintText: 'تأكيد كلمة المرور',
                          text: 'تأكيد كلمة المرور',
                          obscuretext: viewModel.obscure_confirm_password,
                          suffixIcon: const Icon(Icons.lock_outline),
                          prefixIcon: IconButton(
                            icon: Icon(
                              viewModel.obscure_confirm_password
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed:
                                viewModel.toggleConfirmPasswordVisibility,
                          ),
                          validator: viewModel.confirmPasswordValidator,
                        ),
                        if (viewModel.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              viewModel.errorMessage!,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(height: 20),
                        viewModel.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                icon: Icon(Icons.arrow_back),
                                text: 'متابعة',
                                color: Color(0xff1F59DF),
                                textColor: Colors.white,
                                onPressed: () {
                                  viewModel.onContinuePressed(context);
                                },
                              ),
                        SizedBox(height: 15),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'لديك حساب بالفعل؟ ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "تسجيل الدخول",
                                style: TextStyle(
                                  color: Color(0xff1F59DF),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    viewModel.onLoginPressed(context);
                                  },
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        const SizedBox(height: 20),
                      ],
                    ),
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
