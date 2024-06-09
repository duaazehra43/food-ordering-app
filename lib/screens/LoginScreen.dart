import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250.0),
          child: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Image.asset(
                    "assets/images/login_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.red,
              tabs: [
                Tab(
                  text: 'Login',
                ),
                Tab(text: 'Sign Up'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            SignUpTab(),
          ],
        ),
      ),
    );
  }
}

class LoginTab extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Fetch user data from Firestore
      final currentUser = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();
      // Handle user data as required, e.g., save it to a Provider or display it directly

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print("Error signing in: $e");
      // Handle sign-in error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFFFFA4A0C)),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _signInWithEmailAndPassword(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA4A0C),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'SFProRounded',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpTab extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save user data to Firestore
      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .set({
        'name': _firstNameController.text.trim() +
            ' ' +
            _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        // Add more fields as required
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print("Error signing up: $e");
      // Handle sign-up error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _signUpWithEmailAndPassword(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA4A0C),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'SFProRounded',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
