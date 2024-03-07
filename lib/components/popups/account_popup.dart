import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/components/into%20game/custom_button.dart';
import 'package:ocean_cleanup/components/popups/auth_popup.dart';
import 'package:ocean_cleanup/models/user_model.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showAccount(
  BuildContext context,
  bool isLoggedIn,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      print('>>>>>>$isLoggedIn');
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
            child: isLoggedIn
                ? FutureBuilder<UserModel?>(
                    future: authBloc.getUserData(authBloc.state.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final user = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.orange,
                                  size: SizeConfig.largeText1,
                                ),
                              ),
                            ),
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              backgroundColor: Color(0xFF6874ca),
                            ),
                            Text(
                              user.username,
                              style: TextStyle(
                                fontSize: SizeConfig.mediumText1,
                                color: const Color(0xFF6874ca),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'wendyOne',
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_events_rounded,
                                  color: Colors.orange,
                                  size: SizeConfig.largeText1,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  user.score.toString(),
                                  style: TextStyle(
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'comicNeue',
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomButton(
                              onTap: () {
                                authBloc.signOut(context);
                                Navigator.of(context).pop();
                              },
                              text: 'Log Out',
                            )
                          ],
                        );
                      } else {
                        return Text('Error: ${snapshot.error}');
                      }
                    })
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.orange,
                            size: SizeConfig.largeText1,
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        backgroundColor: Color(0xFF6874ca),
                      ),
                      Text(
                        'Guest',
                        style: TextStyle(
                          fontSize: SizeConfig.mediumText1,
                          color: const Color(0xFF6874ca),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'wendyOne',
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        onTap: () => showAuth(context),
                        text: 'Login / Register',
                      ),
                    ],
                  ),
          ),
        ),
      );
    },
  );
}
