import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

//Tao model
class User {
  int id;
  String username;
  String password;
  String avatar;
  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.avatar});
}

//Khai bao Screen (Activity trong android - Lop ket noi voi giao dien = man hinh)
class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() {
    return _UserListScreenState();
  }
}

class _UserListScreenState extends State<UserListScreen> {
  late List<User> users;
  @override
  void initState() {
    super.initState();
    users = [];
    fetchUsers();
  }

  //doc du lieu tu server: map
  //Ham convert map -> list
  List<User> convertMapToList(Map<String, dynamic> data) {
    List<User> us = [];
    data.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        User user = User(
            id: value[i]['id'] ?? 0,
            username: value[i]['username'] ?? '',
            password: value[i]['password'] ?? '',
            avatar: value[i]['avatar']);
        us.add(user);
      }
    });
    return us;
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse("http://localhost/api.php"));
    if (response.statusCode == 200) {
      print('Receive json: ${response.body}');
      final List<dynamic> arr = json.decode(response.body);
      print(arr);
      List<User> us = [];
      for (int i = 0; i < arr.length; i++) {
        us.add(User(
            id: int.parse(arr[i]['id']),
            username: arr[i]['username'],
            password: arr[i]['password'],
            avatar: arr[i]['avatar']));
      }
      // Thiet lap trang thai moi
      setState(() {
        users = us;
      });
    } else {
      throw Exception("Khong co du lieu ");
    }
  }

  //Layout hien thi du lieu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sach user'),
      ),
      body: users != null
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Password ${users[index].password}')],
                  ),
                  leading: Image.network(users[index].avatar,
                      width: 50, height: 50, fit: BoxFit.cover),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetail(users[index])));
                  },
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class UserDetail extends StatelessWidget {
  final User user;
  UserDetail(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(0.0)),
          Image.network(
            user.avatar,
            width: 100,
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Text('ID: ${user.id}'),
          ),
          Padding(padding: EdgeInsets.all(0.0)),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Text('Username: ${user.username}'),
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Text('Password: ${user.password}'),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Danh sach nguoi dung",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
          // Dinh nghia btn goi listScreen
          child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserListScreen()));
        },
        child: Text("Go to List Screen"),
      )),
    );
  }
}

void main() {
  runApp(const MyApp());
}
