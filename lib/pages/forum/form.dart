import 'package:flutter/material.dart';
import 'package:navigate/pages/forum/questionpage.dart';

class Forum extends StatelessWidget {
  final bool isLoggedIn; // Declare isLoggedIn as a variable
  const Forum({Key? key, required this.isLoggedIn}) : super(key: key);

  void _goToQuestionPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Question()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forum Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            if (isLoggedIn) // Conditionally show the button
              ElevatedButton(
                onPressed: () => _goToQuestionPage(context),
                child: Text('Go to Question Page'),
              ),
          ],
        ),
      ),
    );
  }
}
