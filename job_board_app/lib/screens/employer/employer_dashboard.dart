import 'package:flutter/material.dart';
import 'post_job_screen.dart';
import 'manage_jobs_screen.dart';

class EmployerDashboard extends StatefulWidget {
  @override
  _EmployerDashboardState createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeDashboard(),
    ManageJobsScreen(), // Applications tab
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
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
      ),
    );
  }
}

// ================= HOME DASHBOARD UI =================

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // HEADER
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

                // POST JOB BUTTON
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

                SizedBox(height: 20),

                _buildStatCard("Total Jobs Posted", "12"),
                SizedBox(height: 12),
                _buildStatCard("Total Applicants", "842"),

                SizedBox(height: 20),

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

  // STAT CARD
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(Icons.work_outline, size: 40, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  // JOB CARD
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

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.work, color: Colors.blue),
          ),

          SizedBox(width: 10),

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
}