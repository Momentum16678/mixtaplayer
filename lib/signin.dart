
import 'package:flutter/material.dart';
import 'package:mixtaplayer/api_service.dart';
import 'package:mixtaplayer/login_response.dart';
import 'package:mixtaplayer/musiclist.dart';
import 'package:mixtaplayer/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;


  final signupCall = ApiCalls();
  LoginResponseModel? signInData;

  requestSignIn() async {
    signInData = await signupCall.Login(
      emailController.text,
      _passwordController.text,
    );
    if (signInData != null) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MusicList()));
    } else {
      print(signInData.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(14,0,21,1),
                    Color.fromRGBO(49,2,72,1),
                    Color.fromRGBO(14,0,21,1)
                  ]
              )
          ),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter email",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
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
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
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
                    const SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await requestSignIn();
                            //SharedPreferences prefs = await SharedPreferences.getInstance();
                            //prefs.setString("email", "useremail@email.com");
                          }
                        },
                        child: Container(
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(103, 0, 176, 1),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Sign In",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account yet?  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()));
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: GestureDetector(
                        onTap: () {
                          signup(context);
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color.fromRGBO(102, 0, 153, 1)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 58.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/gogle_icon.jpg",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "Sign up with google",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signup(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MusicList()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

}