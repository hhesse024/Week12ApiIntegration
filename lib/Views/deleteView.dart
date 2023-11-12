import 'package:flutter/material.dart';
import 'package:morseth_week11/Repositories/UserClient.dart';

UserClient userClient = UserClient();

Future<void> showDeleteConfirmation(BuildContext context, ID) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () {
              // Call the API to delete the user using the userId
              userClient.DeleteUserAsync(ID);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
