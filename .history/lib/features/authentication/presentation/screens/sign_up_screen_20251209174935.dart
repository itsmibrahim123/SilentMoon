import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool emailValid = false;
  bool nameValid = false;
  bool passwordValid = false;
  bool passwordVisible = false;
  bool privacyChecked = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double w(double px) => px * width / 414;
    double h(double px) => px * height / 896;
    double fs(double px) => px * width / 414;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // signINBG background
          Positioned(
            left: w(-41.71),
            top: h(-77.77),
            child: Opacity(
              opacity: 1,
              child: Transform.rotate(
                angle: 0, // 0 degrees
                child: Image.asset(
                  'assets/images/signINBG.png',
                  width: w(547.1941528320312),
                  height: h(428.235107421875),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Back button
          Positioned(
            left: w(20.24),
            top: h(50),
            child: Container(
              width: w(55.0),
              height: w(55.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFEBEAEC), width: 1),
                shape: BoxShape.circle,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF3F414E),
                      size: w(28),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Title
          Positioned(
            left: w(70.5),
            top: h(133.47),
            child: SizedBox(
              width: w(273),
              height: h(38),
              child: Text(
                'Create your Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontWeight: FontWeight.w700,
                  fontSize: fs(26),
                  height: 1.35,
                  color: Color(0xFF3F414E),
                ),
              ),
            ),
          ),
          // Facebook button
          Positioned(
            left: w(20),
            top: h(204.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: Color(0xFF7583CA),
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: w(24),
                    top: h(12),
                    child: Image.asset(
                      'assets/images/fbLogo.png',
                      width: w(39),
                      height: h(39),
                    ),
                  ),
                  Center(
                    child: Text(
                      'CONTINUE WITH FACEBOOK',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(14),
                        height: 1.081,
                        letterSpacing: 0.05 * fs(14),
                        color: Color(0xFFF6F1FB),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Google button
          Positioned(
            left: w(20),
            top: h(287.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEBEAEC), width: 1),
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: w(24),
                    top: h(12),
                    child: Image.asset(
                      'assets/images/googleLogo.png',
                      width: w(39),
                      height: h(39),
                    ),
                  ),
                  Center(
                    child: Text(
                      'CONTINUE WITH GOOGLE',
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(14),
                        height: 1.081,
                        letterSpacing: 0.05 * fs(14),
                        color: Color(0xFF3F414E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // OR LOG IN WITH EMAIL
          Positioned(
            left: 0,
            right: 0,
            top: h(390.47),
            child: Center(
              child: SizedBox(
                width: w(250),
                child: Text(
                  'OR LOG IN WITH EMAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w700,
                    fontSize: fs(14),
                    height: 1.08,
                    letterSpacing: 2.8 * width / 414,
                    color: Color(0xFFA1A4B2),
                  ),
                ),
              ),
            ),
          ),
          // Name field
          Positioned(
            left: w(20),
            top: h(444.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F7),
                borderRadius: BorderRadius.circular(w(15)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: w(20), right: w(20)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      onChanged: (val) {
                        setState(() {
                          nameValid = val.trim().isNotEmpty;
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(16),
                        color: Color(0xFF3F414E),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w300,
                          fontSize: fs(16),
                          color: Color(0xFFA1A4B2),
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (nameValid)
                    Image.asset(
                      'assets/images/tickLogo.png',
                      width: w(22),
                      height: h(22),
                    ),
                ],
              ),
            ),
          ),
          // Email field
          Positioned(
            left: w(20),
            top: h(527.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F7),
                borderRadius: BorderRadius.circular(w(15)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: w(20), right: w(20)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      onChanged: (val) {
                        setState(() {
                          emailValid = RegExp(
                            r"^[^@\s]+@[^@\s]+\.[^@\s]+",
                          ).hasMatch(val);
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(16),
                        color: Color(0xFF3F414E),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email address',
                        hintStyle: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w300,
                          fontSize: fs(16),
                          color: Color(0xFFA1A4B2),
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (emailValid)
                    Image.asset(
                      'assets/images/tickLogo.png',
                      width: w(22),
                      height: h(22),
                    ),
                ],
              ),
            ),
          ),
          // Password field
          Positioned(
            left: w(20),
            top: h(610.47),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F7),
                borderRadius: BorderRadius.circular(w(15)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: w(20), right: w(20)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      onChanged: (val) {
                        setState(() {
                          passwordValid = val.length >= 6;
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w400,
                        fontSize: fs(16),
                        color: Color(0xFF3F414E),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w300,
                          fontSize: fs(16),
                          color: Color(0xFFA1A4B2),
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: Image.asset(
                      'assets/images/eyeLogo.png',
                      width: w(22),
                      height: h(22),
                      color: Color(0xFF3F414E),
                    ),
                  ),
                  if (passwordValid)
                    Image.asset(
                      'assets/images/tickLogo.png',
                      width: w(22),
                      height: h(22),
                    ),
                ],
              ),
            ),
          ),
          // Privacy Policy
          Positioned(
            left: w(20),
            right: w(20),
            top: h(693.47),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w400,
                      fontSize: fs(14),
                      color: Color(0xFFA1A4B2),
                      letterSpacing: 0.05 * fs(14),
                    ),
                    children: [
                      TextSpan(text: 'i have read the '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFF8E97FD),
                          decoration: TextDecoration.none, // Removed underline
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: w(1.5),
                  child: Checkbox(
                    value: privacyChecked,
                    onChanged: (val) {
                      setState(() {
                        privacyChecked = val ?? false;
                      });
                    },
                    activeColor: Color(0xFF8E97FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(color: Color(0xFFA1A4B2), width: 2),
                  ),
                ),
              ],
            ),
          ),
          // GET STARTED button
          Positioned(
            left: w(20),
            top: h(747.63),
            child: Container(
              width: w(374),
              height: h(63),
              decoration: BoxDecoration(
                color: Color(0xFF8E97FD),
                borderRadius: BorderRadius.circular(w(38)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E97FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w(38)),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed:
                    privacyChecked && nameValid && emailValid && passwordValid
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w400,
                    fontSize: fs(14),
                    height: 1.081,
                    letterSpacing: 0.05 * fs(14),
                    color: Color(0xFFF6F1FB),
                  ),
                ),
              ),
            ),
          ),
          // Bottom bar
          Positioned(
            left: w(136),
            top: h(882),
            child: Container(
              width: w(143),
              height: h(5),
              decoration: BoxDecoration(
                color: Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(w(2.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
