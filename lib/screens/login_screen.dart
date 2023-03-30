import 'package:email_validator/email_validator.dart';
import 'package:flash_chat_starting_project/components/rounded_button.dart';
import 'package:flash_chat_starting_project/services/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '/constants.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool erroreOccured = false, showSpinner = false;
 // var auth = FirebaseAuth.instance;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 300.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
             Form(
              key: _formKey,
               child: Column(
                 children: [
                   TextFormField(
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Enter your email',
                          labelText: 'Email',
                       
                          ),
                         controller: _emailController,
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
              controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password){
                  return password != null && password.length>5 ? null: 'The password should be at least 6 characters';
                },
              ),
                 ],
               ),
             ),
           
              const SizedBox(
                height: 24.0,
              ),
                   Visibility(
                visible: erroreOccured,
                 child: Text(errorMessage,
                           textAlign: TextAlign.center,
                           style: const TextStyle(color: Colors.red),
                           ),
               ),
              RoundedButton(color: kLoginButtonColor,
               onPressed: (){}, title: 'Log In'),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                 
                try{            
                  setState(() {
                    erroreOccured = false;
                    showSpinner = true;
                  });  
                  await   AuthService()
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ChatScreen.id);
                        });
                        setState(() {
                          showSpinner= false;

                        });
                        } catch(e){
                          print('ERROR ${e.toString()}');
                          setState(() {
                            showSpinner = false;
                            erroreOccured = true;
                            errorMessage = e.toString().split('] ')[1];
                          });
                          
                        }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
