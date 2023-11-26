import 'package:flutter/material.dart';
import '../Repositories/UserClient.dart';
import 'package:morseth_week11/main.dart';

class AddUser extends StatefulWidget {
  // Define the callback function
  final Function() onAddUser;

  const AddUser({Key? key, required this.onAddUser}) : super(key: key);

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
    // Call the callback function to pass data to the main class

    // Optionally, you can also perform other actions in this function
    userClient.AddUserAsync(username, password, email, authLevel);
  }
}
