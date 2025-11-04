import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khotwa/components/custom_button.dart';
import 'package:khotwa/components/custom_textfield.dart';
import 'package:khotwa/core/navigations/navigations.dart';
import 'package:khotwa/view/forget_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F9FF),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.9,
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

                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "مرحبا بعودتك",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "سجل دخولك  للوصول الى حسابك",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 30),
                MyTextFiled(
                  controller: email_controller,
                  hintText: 'ادخل بريدك الالكتروني',
                  obscuretext: false,
                  text: 'البريد الالكتروني',
                  suffixIcon: Icon(Icons.email_outlined),
                  prefixIcon: null,
                ),

                SizedBox(height: 10),
                MyTextFiled(
                  controller: password_controller,
                  hintText: 'ادخل كلمة المرور',
                  obscuretext: true,
                  text: 'كلمة المرور',
                  suffixIcon: Icon(Icons.lock_outline),
                  prefixIcon: Icon(Icons.visibility_off_outlined),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("تذكرني"),

                    Checkbox(
                      activeColor: Colors.blueAccent,
                      checkColor: Colors.white,
                      splashRadius: 4,

                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),

                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    SizedBox(width: 50),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'هل نسيت كلمة المرور؟ ',
                            style: TextStyle(
                              color: Color(0xff1F59DF),

                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
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
                SizedBox(height: 5),
                CustomButton(
                  text: 'تسجيل الدخول',
                  icon: Icon(Icons.login_rounded),
                  color: Color(0xff1F59DF),
                  textColor: Colors.white,
                  onPressed: () {},
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: const Divider(
                          color: Color.fromARGB(255, 247, 239, 239),
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
                        child: const Divider(
                          color: Color.fromARGB(255, 247, 239, 239),
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
                  icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                CustomButton(
                  text: 'تسجيل الدخول بفيسبوك ',
                  icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'ليس لديك حساب؟ ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: "إنشاء حساب جديد",
                        style: TextStyle(
                          color: Color(0xff1F59DF),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                AppNavigation.push(context, ForgetPage());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
