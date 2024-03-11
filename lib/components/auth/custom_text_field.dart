import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.validator,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth / 2.2,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF6874ca),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontFamily: 'comicNeue'),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.orange,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Color(0xFF6874ca)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Color(0xFF6874ca)),
          ),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
