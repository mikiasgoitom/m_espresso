import 'package:flutter/material.dart';
import 'package:m_espresso_v1/ui/screens/login_screen.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';
import 'package:m_espresso_v1/ui/widgets/text_field.dart';
import 'package:m_espresso_v1/ui/widgets/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Apptheme.backgroundColor,
      body: SafeArea(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: height / 2.7,
              child: Image.asset('assets/images/auth.png'),
            ),
            TextFeildInput(
              textEditingController: nameController,
              hintText: 'Enter your name',
              icon: Icons.person,
            ),
            TextFeildInput(
              textEditingController: emailController,
              hintText: 'Enter your email',
              icon: Icons.email,
            ),
            TextFeildInput(
              textEditingController: passwordController,
              hintText: 'Enter your password',
              icon: Icons.lock,
              isPass: true,
            ),
            TextFeildInput(
              textEditingController: passwordController,
              hintText: 'Confirm your password',
              icon: Icons.lock,
              isPass: true,
            ),
            CommonButton(
              onTap: () {},
              text: 'Sign Up',
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Aleady have an account?',
                  style: TextStyle(
                    color: Apptheme.orange1Color,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  child: const Text(
                    ' Login',
                    style: TextStyle(
                      color: Apptheme.orange2Color,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
