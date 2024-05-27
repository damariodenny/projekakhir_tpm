import 'package:flutter/material.dart';
import 'package:projekakhir/database_helper.dart';
import 'package:projekakhir/enkripsi_service.dart';
import 'package:projekakhir/register_screen.dart';
import 'package:projekakhir/session_service.dart';
import 'package:projekakhir/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final EncryptionService _encryptionService = EncryptionService();
  final SessionService _sessionService = SessionService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _handleLogin(context);
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final encryptedPassword = await _encryptionService.encrypt(password);
    print('Encrypted Password: $encryptedPassword'); // Debugging line
    final user = await _databaseHelper.getUser(username);

    if (user != null) {
      print('User found: ${user.username}'); // Debugging line
      if (user.password == encryptedPassword) {
        await _sessionService.saveSession(username);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()), // Pastikan BottomNavigation diimplementasikan
        );
      } else {
        print('Password does not match'); // Debugging line
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Username or password is incorrect',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
        );
      }
    } else {
      print('User not found'); // Debugging line
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Username or password is incorrect',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      );
    }
  }
}
