import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true, // Hide password text
          ),
          SizedBox(height: 20),
         ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gameList');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Set button color to green
            ),
            child: Text('Login'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Navigate to the registration screen here
              // You can replace '/registration' with the actual route for your registration screen
              Navigator.pushNamed(context, '/registration');
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}