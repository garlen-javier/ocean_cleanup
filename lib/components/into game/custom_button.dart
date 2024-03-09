import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth / 2.5,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF6874ca),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.smallText1,
                fontWeight: FontWeight.bold,
                fontFamily: 'wendyOne',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
