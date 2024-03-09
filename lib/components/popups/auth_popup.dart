import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/components/auth/custom_text_field.dart';
import 'package:ocean_cleanup/components/auth/error_dialog.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showAuth(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final TextEditingController usernameController = TextEditingController();
      final TextEditingController passwordController = TextEditingController();
      final formKey = GlobalKey<FormState>();
      final authBloc = BlocProvider.of<AuthBloc>(context);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Color(0xFF6874ca), width: 5),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: SizeConfig.screenWidth / 2.5,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.loading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const AlertDialog(
                      title: Text(
                        'Loading',
                        style: TextStyle(
                          color: Color(0xFF6874ca),
                          fontFamily: "wendyOne",
                        ),
                      ),
                      content: Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  );
                } else if (state.status == AuthStatus.success) {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LevelsScreen(),
                    ),
                    (route) => false,
                  );
                } else if (state.status == AuthStatus.failure) {
                  Navigator.of(context).pop();
                  showErrorDialog(context, state.error ?? 'Unknown error');
                }
              },
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.orange,
                                size: SizeConfig.mediumText1,
                              ),
                            ),
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: const Color(0xFF6874ca),
                              fontSize: SizeConfig.mediumText1,
                              fontWeight: FontWeight.bold,
                              fontFamily: "wendyOne",
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: usernameController,
                            labelText: 'Username',
                            prefixIcon: Icons.person,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            labelText: 'Password',
                            prefixIcon: Icons.key_rounded,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (passwordController.text.length < 6) {
                                      showErrorDialog(context,
                                          'Password must be at least 6 characters');
                                      return;
                                    }
                                    authBloc.signUp(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authBloc.login(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
