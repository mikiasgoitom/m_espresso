// main_screen.dart
import 'package:flutter/material.dart';
import 'package:m_espresso_v1/ui/widgets/widgets.dart';
import 'package:m_espresso_v1/ui/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_espresso_v1/ui/theme/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const PendingPaymentsScreen(pendingPayments: [])
  ];
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to LoginScreen after logging out
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const IntroductionScreen(),
        ),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      print('Logout error: $e'); // Debugging purpose
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to logout. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('M Espresso'),
        backgroundColor: Apptheme.buttonBackground1Color,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
