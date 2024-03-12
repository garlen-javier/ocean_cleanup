import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/components/auth/custom_text_field.dart';
import 'package:ocean_cleanup/components/auth/error_dialog.dart';
import 'package:ocean_cleanup/screens/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class AuthPopup extends StatelessWidget {
  const AuthPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: const Color(0xFF6874ca),
              size: SizeConfig.mediumText1,
            ),
          ),
          const Spacer(),
          Text(
            'Welcome',
            style: TextStyle(
              color: Colors.orange,
              fontSize: SizeConfig.mediumText1,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
      content: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Loading',
                  style: TextStyle(
                    color: Color(0xFF6874ca),
                    fontFamily: "wendyOne",
                    
                  ),
                ),
                content: SizedBox(
                  height: SizeConfig.screenHeight / 5,
                  width: SizeConfig.screenWidth / 5,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [

        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (passwordController.text.length < 6) {
                showErrorDialog(
                    context, 'Password must be at least 6 characters');
                return;
              }
              authBloc.signUp(
                username: usernameController.text,
                password: passwordController.text,
              );
            }
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
              fontSize: SizeConfig.smallText1,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              authBloc.login(
                username: usernameController.text,
                password: passwordController.text,
              );
            }
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
              fontSize: SizeConfig.smallText1,
            ),
          ),
        ),
      ],
    );
  }
}
