// This is the entry point for the Sign In and Sign Up screen.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Beige background image
          Positioned(
            left: -3,
            top: 0,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/beigeBG.png',
                width: 423,
                height: 504,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Sofa girl image
          Positioned(
            left: 40.69,
            top: 160,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/sofaGirl.png',
                width: 332.22,
                height: 242.69,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo
          Positioned(
            left: 123,
            top: 50,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/logo.png',
                width: 168,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Text box container
          Positioned(
            left: 58,
            top: 534,
            width: 298,
            height: 109,
            child: Column(
              children: [
                // First row - "We are what we do"
                Container(
                  width: 274,
                  height: 42,
                  alignment: Alignment.center,
                  child: const Text(
                    'We are what we do',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      height: 1.35,
                      letterSpacing: 0,
                      color: Color(0xFF3F414E),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Second row - description text
                Container(
                  width: 298,
                  height: 52,
                  alignment: Alignment.center,
                  child: const Text(
                    'Thousand of people are using silent moon\nfor smalls meditation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      height: 1.65,
                      letterSpacing: 0,
                      color: Color(0xFFA1A4B2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom container
          Positioned(
            left: 20,
            top: 705,
            width: 374,
            height: 97,
            child: Column(
              children: [
                // Sign Up button
                Container(
                  width: 374,
                  height: 63,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E97FD),
                    borderRadius: BorderRadius.circular(38),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E97FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(38),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.08,
                        letterSpacing: 0.7, // 5% of 14
                        color: Color(0xFFF6F1FB),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Already have an account text with LOG IN
                SizedBox(
                  width: 282,
                  height: 14,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.08,
                        letterSpacing: 0.7, // 5% of 14
                        color: Color(0xFF3F414E),
                      ),
                      children: [
                        const TextSpan(text: 'ALREADY HAVE AN ACCOUNT? '),
                        TextSpan(
                          text: 'LOG IN',
                          style: const TextStyle(
                            color: Color(0xFF8E97FD),
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.08,
                            letterSpacing: 0.7,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
