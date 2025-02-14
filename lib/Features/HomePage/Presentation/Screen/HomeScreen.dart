import 'package:flutter/material.dart';
import 'package:weatherapp/Core/Component/Button.dart';
import 'package:weatherapp/Core/Utilities/Colors.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/auth.dart';

class homeScreen extends StatefulWidget {

  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool _isLoading = false;

  Future<void> _signOut(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Auth().signout(context: context);

    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator() // Show loading indicator
            else
              CustomButton(
                backgroundColor: signOutButton,
                text: "SignOut",
                onPressed: () async {
                  await _signOut(context); // Trigger sign-out
                },
              ),
          ],
        ),
      ),
    );
  }
}
