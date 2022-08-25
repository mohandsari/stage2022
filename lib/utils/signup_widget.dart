// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:auth/database/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../main.dart';
import 'utils.dart';
import '../models/userM.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final nameController = TextEditingController();
  final telController = TextEditingController();
  final siretController = TextEditingController();
  final zipcodeController = TextEditingController();
  final adressController = TextEditingController();
  final cityController = TextEditingController();
  final roleController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passWordController.dispose();
    telController.dispose();
    siretController.dispose();
    adressController.dispose();
    zipcodeController.dispose();
    cityController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                TextFormField(
                  controller: nameController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Name'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: siretController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'siret'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: telController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Tél'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: adressController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Adress'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: zipcodeController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'ZIP CODE'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: cityController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'City'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Email'),
                  obscureText: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'enter a valid email'
                          : null,
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: passWordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'enter min. 6 caractères'
                      : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      //minimumSize: Size(50, 10),
                      ),
                  icon: Icon(Icons.lock_open, size: 32),
                  label: Text(
                    'sign Up',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: signUp,
                ),
                SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    text: 'Already have an account ?',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passWordController.text.trim(),
      );
      if (result.user != null) {
        await DBservices().saveUser(UserM(
            id: result.user!.uid,
            email: emailController.text.trim(),
            name: nameController.text.trim(),
            tel: telController.text.trim(),
            adress: adressController.text.trim(),
            zipcode: zipcodeController.text.trim(),
            city: cityController.text.trim(),
            role: roleController.text.trim()));
      }
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    // Navigator.of(contezt) not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
