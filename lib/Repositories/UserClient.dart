import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:morseth_week11/main.dart';
import 'package:morseth_week11/Models/AuthResponse.dart';
import 'package:morseth_week11/Views/usersView.dart';
import '../Models/User.dart';
import './DataService.dart';
import '../Models/LoginStructure.dart';

const String BaseUrl = "https://cmsc2204-mobile-api.onrender.com/Auth";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  DataService _dataService = DataService();

  BuildContext? get context => null;

  Future<AuthResponse?> Login(LoginStructure user) async {
    try {
      var response = await _dio.post("/login",
          data: {'username': user.username, 'password': user.password});

      var data = response.data['data'];

      var authResponse = new AuthResponse(data['userId'], data['token']);

      if (authResponse.token != null) {
        await _dataService.AddItem("token", authResponse.token);
      }

      return authResponse;
    } catch (error) {
      return null;
    }
  }

  Future<List<User>?> GetUsersAsync() async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        var response = await _dio.get("/GetUsers",
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            }));
        List<User> users = List.empty(growable: true);

        if (response != null) {
          for (var user in response.data) {
            users.add(User(user["_id"], user["Username"], user["Password"],
                user["Email"], user["AuthLevel"]));
          }

          return users;
        }
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future AddUserAsync(username, password, email, authLevel) async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        final data = {
          "username": "$username",
          "password": "$password",
          "email": "$email",
          "authLevel": "$authLevel",
        };
        var response = await _dio.post("/AddUser",
            data: data,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            }));
        if (response.statusCode == 200) {
          //
        } else {
          // Handle the error, such as displaying an error message
          print("Error: ${response.data}");
        }
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> DeleteUserAsync(ID) async {
    try {
      var token = await _dataService.TryGetItem("token");
      if (token != null) {
        final data = {"id": "$ID"};
        var response = await _dio.post("/DeleteUserById",
            data: data,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            }));

        if (response.statusCode == 200) {
          Navigator.push(
            context!,
            MaterialPageRoute(
                builder: (context) => UsersView(
                      inUsers: [],
                    )),
          );
        } else {
          print("Error: ${response.data}");
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<String> GetApiVersion() async {
    var response = await _dio.get("/ApiVersion");
    return response.data;
  }
}
