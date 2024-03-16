import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      scaffoldMessengerKey: scaffoldKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(scaffoldKey: scaffoldKey)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splashscreen.jpg',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool signUpWithEmailOption = true;

  void signUpWithEmail(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    BuildContext? dialogContext;

    try {
      dialogContext = context;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed up successfully, you can navigate to the next screen or perform other actions.
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: dialogContext ?? context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign Up Failed'),
            content: Text(e.message ?? "An error occurred"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void signUpWithPhone(BuildContext context) async {
    String phoneNumber = phoneNumberController.text;

    BuildContext? dialogContext;

    try {
      dialogContext = context;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          // User signed up successfully, you can navigate to the next screen or perform other actions.
        },
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
            context: dialogContext ?? context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Sign Up Failed'),
                content: Text(e.message ?? "An error occurred"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: dialogContext ?? context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign Up Failed'),
            content: Text(e.message ?? "An error occurred"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/login2.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  color: Colors.white,
                  height: 350,
                  width: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (signUpWithEmailOption)
                          Column(
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  signUpWithEmail(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreenAccent,
                                ),
                                child: const Text(
                                  'Sign Up with Email',
                                  style: TextStyle(fontSize: 28),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              TextField(
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  signUpWithPhone(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreenAccent,
                                ),
                                child: const Text(
                                  'Sign Up with Phone Number',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              signUpWithEmailOption = !signUpWithEmailOption;
                            });
                          },
                          child: Text(
                            signUpWithEmailOption
                                ? 'Sign Up with Phone Number'
                                : 'Sign Up with Email',
                            style:const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  const LoginPage({super.key, required this.scaffoldKey});

  static LoginPage withScaffoldKey(GlobalKey<ScaffoldMessengerState> scaffoldKey) {
    return LoginPage(key: UniqueKey(), scaffoldKey: scaffoldKey);
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loginWithEmailOption = true;

  void signIn(BuildContext context, String? email, String? password) async {
    if (email == null || password == null) {
      throw FirebaseAuthException(message: "Email or password cannot be null", code: '');
    }

    // Obtain a fresh BuildContext outside the try/catch block
    BuildContext dialogContext;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User signed in successfully
      if(!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DashboardPage(scaffoldKey: widget.scaffoldKey, )),
      );
    } on FirebaseAuthException catch (e) {
      // Obtain a fresh BuildContext within the try/catch block for UI operations
      showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return AlertDialog(
            title: const Text('Login Failed'),
            content: Text(e.message ?? "An error occurred"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Use the fresh dialogContext
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/login2.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: Colors.white,
                  height: 350,
                  width: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (loginWithEmailOption)
                        Column(
                          children: [
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                          ],
                        )
                      else
                        const Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (loginWithEmailOption) {
                            signIn(context, emailController.text, passwordController.text);
                          } else {
                            // Logic for sign in with phone number
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                        ),
                        child: Text(
                          loginWithEmailOption ? 'Login with Email' : 'Login with Phone Number',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            loginWithEmailOption = !loginWithEmailOption;
                          });
                        },
                        child: Text(
                          loginWithEmailOption
                              ? 'Login with Phone Number'
                              : 'Login with Email',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    Future<void> resetPassword() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: 'Password reset email sent successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Show success message or navigate to a success page
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Failed to send password reset email: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        // Show error message
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/login2.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: Colors.white,
                  height: 350,
                  width: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter your email address to receive a password reset link:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: emailController,
                        decoration:const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}