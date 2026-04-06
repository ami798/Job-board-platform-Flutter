import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // 🔹 GET USERS
  Future<void> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:3000/api/users"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          users = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 DELETE USER
  Future<void> deleteUser(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("http://127.0.0.1:3000/api/users/$id"),
      );

      if (response.statusCode == 200) {
        fetchUsers();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User deleted")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      appBar: AppBar(
        title: Text("User Management"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? Center(child: Text("No users found"))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return _userCard(user);
                  },
                ),
    );
  }

  Widget _userCard(Map user) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['name'] ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                user['role'] ?? "",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              deleteUser(user['_id']);
            },
          )
        ],
      ),
    );
  }
}