import 'package:flutter/material.dart';
import '../Repositories/UserClient.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  AddUserState createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController authLevelController = TextEditingController();
  UserClient userClient = UserClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: authLevelController,
              decoration: InputDecoration(labelText: 'Auth Level'),
            ),
            // Add more input fields as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          confirmAddButtonPress(
              usernameController.text,
              passwordController.text,
              emailController.text,
              authLevelController.text);
        },
        child: Icon(Icons.check),
      ),
    );
  }

  confirmAddButtonPress(username, password, email, authLevel) {
    userClient.AddUserAsync(username, password, email, authLevel);
  }
}
