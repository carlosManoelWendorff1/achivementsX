import 'package:flutter/material.dart';

void main() => runApp(ProfileScreen());

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      int _currentIndex = 0;

    return Scaffold(
        body: ProfileWidget(),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (int index) {
          if (index == 1) {
            // Navigate to the /login route when "Settings" tab is tapped
            Navigator.of(context).pushNamed('/gameList');
          }
           if (index == 2) {
            // Navigate to the /login route when "Settings" tab is tapped
            Navigator.of(context).pushNamed('/login');
          }
        },
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'logout',
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/abner.jpg'), // Replace with your profile image
        ),
        SizedBox(height: 20),
        Text(
          'John Doe', // Replace with the user's name
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'johndoe@email.com', // Replace with the user's email
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        Divider(),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone Number'),
          subtitle: Text('+1 (123) 456-7890'), // Replace with the user's phone number
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Location'),
          subtitle: Text('123 Main Street, City, Country'), // Replace with the user's location
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Bio'),
          subtitle: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat libero at nulla pellentesque, eu condimentum tortor consequat.'
          ), // Replace with the user's bio
        ),
      ],
    );
  }
}
