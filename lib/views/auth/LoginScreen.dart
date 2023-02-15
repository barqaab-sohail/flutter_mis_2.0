import 'package:first_project/controllers/auth/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
                    child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/mono.png',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            TextFormField(
                              controller: loginController.emailController,
                              onSaved: (value) {
                                loginController.email = value!;
                              },
                              validator: (value) {
                                return loginController.validateEmail(value!);
                              },
                              decoration: const InputDecoration(
                                labelText: 'email',
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: loginController.passwordController,
                              onSaved: (value) {
                                loginController.password = value!;
                              },
                              validator: (value) {
                                return loginController.validatePassword(value!);
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'password',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  onPressed: () {
                                    loginController.loginWithEmail(
                                        formkey: _formKey);
                                  },
                                  child: Text('Login'),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  onPressed: () {},
                                  child: Text('Reset'),
                                )
                              ],
                            )
                          ],
                        ))))));
  }
}
