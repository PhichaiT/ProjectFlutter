import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets_basic/component/my_button.dart';
import 'package:widgets_basic/component/my_iconbutton.dart';
import 'package:widgets_basic/component/my_textbutton.dart';

class MyTextFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final IconData icon;
  final Color boxColor;
  final Color borderColor;

  MyTextFieldWithIcon({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.icon,
    required this.boxColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        filled: true,
        fillColor: boxColor,
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      _showMyDialog('Success', 'Register successful.');
    } on FirebaseAuthException catch (e) {
      print('Failed, with error code: ${e.code}');
      print(e.message);

      if (e.code == 'invalid-email') {
        _showMyDialog('Error', 'No user found for the email.');
      } else if (e.code == 'email-already-in-use') {
        _showMyDialog('Error', 'Email already in use.');
      }
    }
  }

  void _showMyDialog(String title, String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void signUpUser() async {
    if (emailController.text != "" && passwordController.text != "") {
      print("It's ok");
    } else {
      print('Please input your email and password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background_image2.gif'), // Replace with your image asset path
              fit:
                  BoxFit.cover, // You can adjust the fit as per your preference
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Form(
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(50, 41, 255, 59),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Please register your username and password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(50, 41, 255, 59),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "and get ready to shop!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextFieldWithIcon(
                    controller: emailController,
                    hintText: 'Enter your username',
                    labelText: 'Username',
                    obscureText: false,
                    icon: Icons.person,
                    boxColor: Color.fromARGB(100, 200, 200, 200),
                    borderColor: Colors.green,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  MyTextFieldWithIcon(
                    controller: passwordController,
                    hintText: 'Enter your password here',
                    labelText: 'Password',
                    obscureText: true,
                    icon: Icons.lock,
                    boxColor: Color.fromARGB(100, 200, 200, 200),
                    borderColor: Colors.green,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFieldWithIcon(
                    controller: passwordController,
                    hintText: 'Confirm your password',
                    labelText: 'Confirm Password',
                    obscureText: true,
                    icon: Icons.lock,
                    boxColor: Color.fromARGB(100, 200, 200, 200),
                    borderColor: Colors.green,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(
                      onTap: createUserWithEmailAndPassword,
                      hintText: 'Sign Up'),

                  const SizedBox(
                    height: 25,
                  ),
                  //Icon button
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyIconButton(imagePath: 'assets/images/google.png'),
                      MyIconButton(imagePath: 'assets/images/Steam.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.displaySmall,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const MyTextButton(
                          lableText: 'login now',
                          pageRoute: 'login',
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ));
  }
}
