import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostJobScreen extends StatefulWidget {
  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {

  // 🔹 Controllers
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;

  // 🔹 API CALL
  Future<void> postJob() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse("http://127.0.0.1:3000/api/jobs"); // 🔴 CHANGE THIS

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": titleController.text,
          "company": companyController.text,
          "location": locationController.text,
          "salary": salaryController.text,
          "description": descriptionController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Job posted successfully")),
        );

        // 🔹 Clear fields
        titleController.clear();
        companyController.clear();
        locationController.clear();
        salaryController.clear();
        descriptionController.clear();

        // 🔹 Go back
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to post job")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      appBar: AppBar(
        title: Text("Post Job"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Curate your next",
                style: TextStyle(color: Colors.grey)),

            Text("Great Hire.",
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),

            SizedBox(height: 20),

            _buildTextField("Role title", "e.g. Senior Product Designer", titleController),
            SizedBox(height: 12),

            _buildTextField("Company Name", "e.g. Acme Corp", companyController),
            SizedBox(height: 12),

            _buildTextField("Location", "e.g. New York", locationController),
            SizedBox(height: 12),

            _buildTextField("Salary Range", "e.g. \$80k - \$120k", salaryController),

            SizedBox(height: 20),

            Text("The Opportunity",
                style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Container(
              height: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Describe the role...",
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            // 🔹 BUTTON
            GestureDetector(
              onTap: isLoading ? null : postJob,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("POST JOB",
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            SizedBox(height: 20),

            // 🔹 EXTRA CARD
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.auto_awesome, size: 40, color: Colors.blue),
                  SizedBox(height: 10),
                  Text("Need help drafting?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Use AI to improve your job description",
                      textAlign: TextAlign.center),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔹 REUSABLE FIELD WITH CONTROLLER
  Widget _buildTextField(
      String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}