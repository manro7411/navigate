import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _token = '';
  final storage = FlutterSecureStorage();
  int _selectedIndex = 0;
  bool isLoggedIn = false;


  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final Uri uri = Uri.parse('http://localhost:3000/login');
    final http.Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final String token = responseData['token'];

      await storage.write(key: 'token', value: token);

      setState(() {
        _token = token;
        _errorMessage = '';
        isLoggedIn = true; // Update login status

      });
    } else {
      final String error = responseData['error'];
      setState(() {
        _token = '';
        _errorMessage = error;
      });
    }
  }

  Future<void> _logout() async {
    // Clear the token and perform any necessary logout logic
    await storage.delete(key: 'token');

    setState(() {
      _token = '';
      isLoggedIn = false; // Update login status

    });

    final Uri uri = Uri.parse('http://localhost:3000/logout');
    final http.Response response = await http.post(uri);

    // Perform any necessary error handling or post-logout logic
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData['message'];
      print('Logout: $message');
    } else {
      print('Logout failed');
    }
  }

  Future<String?> _getToken() async {
    final String? token = await storage.read(key: 'token');
    return token;
  }

  @override
  void initState() {
    super.initState();
    _getToken().then((String? token) {
      setState(() {
        _token = token ?? '';
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_token.isEmpty ? 'Login' : 'Logged In'),
      ),
      body: _token.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                ],
              ),
            )
          : Center(
              child: Text('You are logged in.'),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
