import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class StartButton extends StatelessWidget {
  final void Function() onTap;
  const StartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth / 2.5,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF0097B2),
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
          child: const Center(
            child: Text(
              'Play Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
