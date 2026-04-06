import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostJobScreen extends StatefulWidget {
  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;

  Future<void> postJob() async {
    setState(() => isLoading = true);

    try {
      final url = Uri.parse("http://127.0.0.1:3000/api/jobs");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": titleController.text,
          "company": companyController.text,
          "location": locationController.text,
          "salary": salaryController.text,
          "description": descriptionController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
      }
    } catch (e) {}

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text("Post a New Role",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 HEADER TEXT
            Text(
              "Curate your next",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Great Hire.",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Provide the details below to reach our community of highly skilled professionals. Focus on clarity and purpose to attract the right talent.",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 20),

            /// 🔹 ROLE IDENTITY CARD
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(Icons.description, "Role Identity"),

                  SizedBox(height: 15),

                  _field("Job Title", "e.g. Senior Product Designer", titleController),
                  _field("Company Name", "e.g. Acme Corp", companyController),
                  _field("Location", "e.g. New York, NY (Hybrid)", locationController),
                  _field("Salary Range (Annual)", "e.g. \$120,000 - \$160,000", salaryController),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// 🔹 OPPORTUNITY CARD
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(Icons.auto_awesome, "The Opportunity"),

                  SizedBox(height: 15),

                  Text("Job Description",
                      style: TextStyle(fontWeight: FontWeight.w500)),

                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.all(12),
                    height: 140,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEFFE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText:
                            "Outline the responsibilities, required experience, and what makes this role unique...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      _tag("Markdown supported"),
                      SizedBox(width: 10),
                      _tag("Preview enabled"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// 🔹 ACTION SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Save Draft"),
                ElevatedButton(
                  onPressed: isLoading ? null : postJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: StadiumBorder(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("POST JOB"),
                ),
              ],
            ),

            SizedBox(height: 20),

            /// 🔹 AI CARD
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFEDEFFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1677442136019-21780ecad995",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("Need help drafting?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(
                    "Our AI-assisted editor can help refine your job description to better align with industry standards and attract high-quality applicants.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text("Try AI Editor →",
                      style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 REUSABLE CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF1F2F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  /// 🔹 SECTION TITLE
  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 8),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// 🔹 INPUT FIELD
  Widget _field(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFE4E7F5),
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
      ),
    );
  }

  /// 🔹 TAG CHIP
  Widget _tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFE4E7F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 12)),
    );
  }
}