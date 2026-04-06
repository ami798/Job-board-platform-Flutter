import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployerRequestsScreen extends StatefulWidget {
  @override
  _EmployerRequestsScreenState createState() =>
      _EmployerRequestsScreenState();
}

class _EmployerRequestsScreenState
    extends State<EmployerRequestsScreen> {
  List requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  // 🔹 GET REQUESTS
  Future<void> fetchRequests() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:3000/api/employer-requests"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          requests = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 APPROVE / REJECT
  Future<void> updateRequest(String id, String status) async {
    try {
      final response = await http.put(
        Uri.parse(
            "http://127.0.0.1:3000/api/employer-requests/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status": status}),
      );

      if (response.statusCode == 200) {
        fetchRequests();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Request $status")),
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
        title: Text("Employer Requests"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? Center(child: Text("No requests"))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final req = requests[index];

                    return _requestCard(req);
                  },
                ),
    );
  }

  Widget _requestCard(Map req) {
    String status = req['status'] ?? "Pending";

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            req['company'] ?? "",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16),
          ),

          SizedBox(height: 5),

          Text("Status: $status"),

          SizedBox(height: 10),

          if (status == "Pending")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateRequest(req['_id'], "Approved");
                  },
                  child: Text("Approve"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    updateRequest(req['_id'], "Rejected");
                  },
                  child: Text("Reject"),
                ),
              ],
            )
        ],
      ),
    );
  }
}