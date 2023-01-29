import 'package:flash_chat_starting_project/components/rounded_button.dart';

import '/constants.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      // backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextFormField(
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email',
                  labelText: 'Email',

                  ),
                  onChanged: (value){

                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:(email){
                    return email != null && EmailValidator.validate(email)
                    ? null: 'Please enter a valid email';
                  }
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password){
                return password != null && password.length>5 ? null: 'The password should be at least 6 characters';
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: kRegisterButtonColor,
                onPressed: () {},
                title: 'Register'),
            const SizedBox(height: 12),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
