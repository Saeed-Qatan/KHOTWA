// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/components/custom_textfield.dart';
import 'package:khotwa/model/register_data_model.dart';
import 'package:khotwa/vm/register_Info_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => RegisterDataModel(
                firstName: '',
                fatherName: '',
                familyName: '',
                email: '',
                phone: '',
                password: '',
              ),
        ),
        ChangeNotifierProvider(create: (_) => RegisterInfoViewModel()),
      ],
      child: Consumer<RegisterInfoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Color(0xffF6F9FF),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
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
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
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
                          child: Icon(
                            FontAwesomeIcons.userPlus,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        MyTextFiled(
                          controller: viewModel.firstName_controller,
                          hintText: 'علي',
                          obscuretext: false,
                          text: 'اسم الاول',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator:
                              (value) => viewModel.notEmptyValidator(
                                value,
                                "الاسم الأول",
                              ),
                        ),
                        SizedBox(height: 10),
                        MyTextFiled(
                          controller: viewModel.fatherName_controller,
                          hintText: 'ناصر',
                          obscuretext: false,
                          text: 'اسم الاب',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator:
                              (value) => viewModel.notEmptyValidator(
                                value,
                                "اسم الأب",
                              ),
                        ),
                        SizedBox(height: 10),
                        MyTextFiled(
                          controller: viewModel.familyName_controller,
                          hintText: 'محمد',
                          obscuretext: false,
                          text: 'اسم العائلة',
                          suffixIcon: Icon(Icons.person_outline),
                          prefixIcon: null,
                          validator:
                              (value) => viewModel.notEmptyValidator(
                                value,
                                "اسم العائلة",
                              ),
                        ),
                        SizedBox(height: 10),
                        MyTextFiled(
                          controller: viewModel.email_controller,
                          hintText: 'ali@gmail.com',
                          obscuretext: false,
                          text: 'البريد الإلكتروني',
                          suffixIcon: Icon(Icons.email_outlined),
                          prefixIcon: null,
                          validator: viewModel.emailValidator,
                        ),
                        SizedBox(height: 10),
                        MyTextFiled(
                          controller: viewModel.phone_controller,
                          hintText: '+967774165326',
                          obscuretext: false,
                          text: 'رقم الهاتف',
                          suffixIcon: Icon(Icons.phone_outlined),
                          prefixIcon: null,
                          validator:
                              (value) => viewModel.notEmptyValidator(
                                value,
                                "رقم الهاتف",
                              ),
                        ),
                        SizedBox(height: 10),
                        MyTextFiled(
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
                        const SizedBox(height: 10),
                        MyTextFiled(
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        viewModel.onLoginPressed(context);
                                      },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "بالتسجيل، أنت توافق على سياسة الخصوصية والشروط والأحكام",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
