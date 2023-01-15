import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_hub/components/login_button.dart';
import 'package:medicine_hub/components/square_tile.dart';
import 'package:medicine_hub/components/textfield.dart';
import 'package:medicine_hub/section/forgot_pw_page.dart';
import 'package:medicine_hub/section/splashs_screen.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Connectivity
  final Connectivity connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    // checkConnectivity();
  }

  void checkConnectivity() async {
    debugPrint("CALLED");
    var connectionResult = await connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile ||
        connectionResult == ConnectivityResult.wifi) {
      debugPrint("sdfsfsdvsvxvdf");
      signUserIn();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("No Internet Connection"),
          );
        },
      );
    }
  }

  // sign user in method
  void signUserIn() async {
    debugPrint("qwwerrrttrewqwerty");
    // show loading circle
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
          return SplashScreen();
        },
      );

      // try sign in
      debugPrint('Start');
      try {
        // if()
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        // wrong email
        if (e.code == 'user-not-found') {
          // debugPrint("Not user found for that email");
          wrongEmailMessage();
        }

        // wrong password
        else if (e.code == 'wrong-password') {
          // debugPrint("Wrong password la loosu");
          wrongPasswordMessage();
        }
      }
    }

    // Navigator.pop(context);
  }

  // wrong email message popup
  wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("No user found for that email"),
        );
      },
    );
  }

  // wrong password message popup
  wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              "Wrong password la loosu"), ////////////////////////////////Change text before publishing
        );
      },
    );
  }

  final formKey = GlobalKey<FormState>(); //key for form

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    // Icon(Icons.lock, size: 100),
                    Image.asset(
                      "lib/images/logo.png",
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 50),

                    // welcome back, you've been missed
                    Text(
                      'Welcome back you\'ve been missed',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 25),

                    // email textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      type: "email",
                    ),

                    const SizedBox(height: 25),

                    // password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      type: "pwd",
                    ),

                    const SizedBox(height: 10),

                    //forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              ),
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // Sign In button
                    LoginButton(
                      onTap: checkConnectivity,
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // or continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[500],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // google + apple sigin in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // google button
                      children: const [
                        SquareTile(imagePath: 'lib/images/google.png'),

                        SizedBox(
                          width: 25,
                        ),

                        // apple button
                        SquareTile(imagePath: 'lib/images/apple.png')
                      ],
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // not a member ? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member ?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
