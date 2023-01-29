import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_starting_project/components/rounded_button.dart';
import 'package:flash_chat_starting_project/screens/login_screen.dart';
import 'package:flash_chat_starting_project/screens/registration_screen.dart';

import '/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = ColorTween(
      begin: Colors.yellow.shade800,
      end: Colors.grey[900],
    ).animate(controller);
    controller.forward();

    controller.addListener(() {
      print(animation.value);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber.withOpacity(controller.value),
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                      totalRepeatCount: 12,
                      animatedTexts: [TypewriterAnimatedText('Flash Chat')]),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
           RoundedButton(color: kLoginButtonColor, onPressed: (){
            Navigator.pushNamed(context, LoginScreen.id);
           }, title: 'Log In'),
            RoundedButton(color: kRegisterButtonColor, onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);

            }, title: 'Register')
          ],
        ),
      ),
    );
  }
}

