import 'package:flutter/material.dart';

class PostJobScreen extends StatelessWidget {
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

            // 🔹 ROLE
            _buildTextField("Role title", "e.g. Senior Product Designer"),

            SizedBox(height: 12),

            // 🔹 COMPANY
            _buildTextField("Company Name", "e.g. Acme Corp"),

            SizedBox(height: 12),

            // 🔹 LOCATION
            _buildTextField("Location", "e.g. New York"),

            SizedBox(height: 12),

            // 🔹 SALARY
            _buildTextField("Salary Range", "e.g. \$80k - \$120k"),

            SizedBox(height: 20),

            // 🔹 DESCRIPTION
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
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Describe the role...",
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            // 🔹 OPTIONS
            Row(
              children: [
                Checkbox(value: true, onChanged: (v) {}),
                Text("Remote allowed"),
              ],
            ),

            Row(
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                Text("Urgent hiring"),
              ],
            ),

            SizedBox(height: 20),

            // 🔹 BUTTON
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text("POST JOB",
                    style: TextStyle(color: Colors.white)),
              ),
            ),

            SizedBox(height: 20),

            // 🔹 EXTRA CARD (bottom from figma)
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

  // 🔹 REUSABLE TEXT FIELD
  Widget _buildTextField(String title, String hint) {
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