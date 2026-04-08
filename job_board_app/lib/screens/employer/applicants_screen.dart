import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApplicantsScreen extends StatefulWidget {
  final String jobId;
  final String jobTitle;

  const ApplicantsScreen({
    Key? key,
    required this.jobId,
    required this.jobTitle,
  }) : super(key: key);

  @override
  _ApplicantsScreenState createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  List applicants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApplicants();
  }

  // 🔹 FETCH APPLICANTS
  Future<void> fetchApplicants() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:3000/api/jobs/${widget.jobId}/applications"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          applicants = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 ACCEPT / REJECT
  Future<void> updateStatus(String id, String status) async {
    try {
      final response = await http.put(
        Uri.parse("http://127.0.0.1:3000/api/applications/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"status": status}),
      );

      if (response.statusCode == 200) {
        fetchApplicants();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Application $status")),
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
        title: Text(widget.jobTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : applicants.isEmpty
              ? Center(child: Text("No applicants"))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: applicants.length,
                  itemBuilder: (context, index) {
                    final applicant = applicants[index];

                    return _applicantCard(applicant);
                  },
                ),
    );
  }

  // 🔹 APPLICANT CARD
  Widget _applicantCard(Map applicant) {
    String status = applicant['status'] ?? "Pending";

    Color statusColor;
    if (status == "Accepted") {
      statusColor = Colors.green;
    } else if (status == "Rejected") {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange;
    }

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

          Row(
            children: [
              CircleAvatar(
                child: Text(applicant['name'][0]),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant['name'] ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      applicant['role'] ?? "",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // 🔹 ACTION BUTTONS
          if (status == "Pending")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    updateStatus(applicant['_id'], "Accepted");
                  },
                  child: Text("Accept"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    updateStatus(applicant['_id'], "Rejected");
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