import 'package:flutter/material.dart';
import 'post_job_screen.dart';
import 'manage_jobs_screen.dart';


class EmployerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      bottomNavigationBar: _buildBottomNav(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🔹 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Curated Career",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.notifications_none),
                  ],
                ),

                SizedBox(height: 20),

                Text(
                  "OVERVIEW",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),

                SizedBox(height: 5),

                Text(
                  "Employer Dashboard",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 15),

                // 🔹 POST JOB BUTTON
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostJobScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "+ Post Job",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // 🔹 MANAGE JOBS BUTTON (NEW)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ManageJobsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Manage Jobs",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 🔹 STATS
                _buildStatCard("Total Jobs Posted", "12"),
                SizedBox(height: 12),
                _buildStatCard("Total Applicants", "842"),

                SizedBox(height: 20),

                // 🔹 RECENT JOBS HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Job Listings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("View All", style: TextStyle(color: Colors.blue)),
                  ],
                ),

                SizedBox(height: 10),

                // 🔹 JOB LIST
                _buildJobCard("Senior Product Designer", "148", "Active"),
                _buildJobCard("Full Stack Engineer", "26", "Draft"),
                _buildJobCard("Marketing Manager", "67", "Active"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 STAT CARD
  Widget _buildStatCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(Icons.work_outline, size: 40, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  // 🔹 JOB CARD
  Widget _buildJobCard(String title, String applicants, String status) {
    Color statusColor =
        status == "Active" ? Colors.green : Colors.grey;

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
        children: [

          // ICON
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.work, color: Colors.blue),
          ),

          SizedBox(width: 10),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "$applicants applicants",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // STATUS
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
    );
  }

  // 🔹 BOTTOM NAV
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Applications",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}