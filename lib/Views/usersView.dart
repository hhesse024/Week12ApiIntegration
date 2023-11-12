import 'package:flutter/material.dart';
import '../Views/deleteView.dart';
import '../Models/User.dart';
import '../Repositories/AddUser.dart';

class UsersView extends StatefulWidget {
  final List<User> inUsers;
  const UsersView({Key? key, required this.inUsers}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState(inUsers);
}

bool _loading = false;

class _UsersViewState extends State<UsersView> {
  _UsersViewState(users);

  late List<User> users = widget.inUsers;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("View Users"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: users.map((user) {
          return Padding(
            padding: EdgeInsets.all(3),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Username: ${user.Username}"),
                    subtitle: Text("Auth Level: ${user.AuthLevel}"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("UPDATE"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          showDeleteConfirmation(context, user.ID);
                        },
                        child: const Text("DELETE"),
                      ),
                      const SizedBox(width: 8),
                    ],
                  )
                ],
              ),
            ),
          );
        }).toList(),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()));
        },
        child: Icon(Icons.add),
      ),
    ));
  }
}
