import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/widgets/my_form_field.dart';
import 'package:restaurant/widgets/responsive_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          if (!ResponsiveWidget.isSmallScreen(context))
            Expanded(
              child: Container(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    "Login Page",
                    style: GoogleFonts.ralewayDots().copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Hello! Please",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        children: [
                          TextSpan(
                            text: " Login",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: width * .025),
                    MyTextField(
                      controller: phoneController,
                      isPhoneNumber: true,
                      hintText: "Enter your phone",
                      validator: (value) {
                        if (value!.length < 17) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: width * .05),
                    MyTextField(
                      controller: passwordController,
                      isPassword: true,
                      hintText: "Enter your password",
                      validator: (value) {
                        if (value!.length < 8) {
                          return "Password cannot be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: width * .025),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String phone = phoneController.text
                              .trim()
                              .replaceAll(RegExp(r'[-\s()]'), '');
                          String password = passwordController.text.trim();
                          print(phone);
                          print(password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: Text("Login"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
