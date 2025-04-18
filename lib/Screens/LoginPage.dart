import 'package:flutter/material.dart';
import 'package:curemate/utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(const AssetImage('assets/images/loginImage.jpg'), context);
      if (mounted) {
        setState(() {
          _imageLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: _imageLoaded
                  ? Image.asset(
                'assets/images/loginImage.jpg',
                fit: BoxFit.cover,
              )
                  : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF00BCD4),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "Username",
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.2),
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF00BCD4)),
                    ),
                    cursorColor: const Color(0xFF00BCD4),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.2),
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF00BCD4)),
                    ),
                    cursorColor: const Color(0xFF00BCD4),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      backgroundColor: const Color(0xFF00BCD4),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: const Color(0xFF00BCD4),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20.0),
                  const Text("or continue with"),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialIcon('assets/images/google.png'),
                      _buildSocialIcon('assets/images/facebook.png'),
                      _buildSocialIcon('assets/images/apple.png'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return GestureDetector(
      onTap: () {
        // Social login authentication
      },
      child: Container(
        height: 50,
        width: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(assetPath, height: 24, width: 24),
      ),
    );
  }
}
