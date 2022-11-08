// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:convert';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:mixtaplay/api_service.dart';
//import 'package:mixtaplay/music_screen.dart';
import 'package:mixtaplayer/api_service.dart';
import 'package:mixtaplayer/music_screen.dart';
import 'package:mixtaplayer/signin.dart';
import 'package:mixtaplayer/signin_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  static final emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswwordCont = TextEditingController();
  bool _isObscure = true;

  final signupCall = ApiCalls();
  // SignupGetResponse? signUpData;
  SignupResponse? signUpData;

  requestSignUp() async {
    signUpData = await signupCall.signUp(
      emailController.text,
      _usernameController.text,
      _passwordController.text,
    );
    if (signUpData != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MusicScreen()));
      // return signUpData;
    } else {
      print(signUpData.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(14, 0, 21, 1),
                Color.fromRGBO(49, 2, 72, 1),
                Color.fromRGBO(14, 0, 21, 1)
              ])),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 150.0),
                      child: Text(
                        "Mixtaplay",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter email",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);

                          return !emailValid
                              ? 'Enter a Valid Email Address'
                              : null;
                        },
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 20.0),
                          child: Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter username",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username cannot be empty';
                          } else if (value.length < 3) {
                            return 'Username cannot be less than 3';
                          }
                        },
                        controller: _usernameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          hintText: "Not more than 12 characters",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length > 12) {
                            return "Password is minumum of 12 characters";
                          }
                        },
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Not more than 12 characters",
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        controller: _confirmPasswwordCont,
                        validator: (value) {
                          if (value == null) {
                            return "Confirm your password";
                          } else if (value.isEmpty) {
                            return 'Field cannot be empty';
                          } else if (value != _passwordController.text) {
                            return "Password doesn't match";
                          } else if (value.length > 12) {
                            return "Password is minumum of 12 characters";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await requestSignUp();
                          }
                        },
                        child: Container(
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(103, 0, 176, 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Create Account",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInScreen()));
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromRGBO(102, 0, 153, 1))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 58.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/gogle_icon.jpg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Sign up with google",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromRGBO(102, 0, 153, 1))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 58.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/fb_icon.jpg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Sign up with facebook",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

 /* void signInWithFacebook() async {

    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
              'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MusicScreen()),
        );
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: Color.fromRGBO(65, 164, 255, 0.75),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }
}

*/
