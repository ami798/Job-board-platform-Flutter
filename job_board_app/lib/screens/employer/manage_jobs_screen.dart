import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_board_app/screens/employer/applicants_screen.dart';

class ManageJobsScreen extends StatefulWidget {
  @override
  _ManageJobsScreenState createState() => _ManageJobsScreenState();
}

class _ManageJobsScreenState extends State<ManageJobsScreen> {
  List jobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  // 🔹 FETCH JOBS
  Future<void> fetchJobs() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:3000/api/jobs"), // 🔴 CHANGE if needed
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          jobs = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 DELETE JOB
  Future<void> deleteJob(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("http://127.0.0.1:3000/api/jobs/$id"),
      );

      if (response.statusCode == 200) {
        fetchJobs();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Job deleted")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6FA),

        appBar: AppBar(
          title: Text("Manage My Jobs"),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),

          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "All Jobs"),
              Tab(text: "Active"),
              Tab(text: "Drafts"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildJobList(),
            _buildJobList(),
            _buildJobList(),
          ],
        ),
      ),
    );
  }

  // 🔹 JOB LIST (FROM API)
  Widget _buildJobList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (jobs.isEmpty) {
      return Center(child: Text("No jobs found"));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];

        return _jobCard(job);
      },
    );
  }

  // 🔹 JOB CARD
  Widget _jobCard(Map job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ApplicantsScreen(
                jobId: job['_id'],
                jobTitle: job['title'],
              ),
            ),
          );
      },
      child: Container(
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

            // TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job['title'] ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'delete') {
                      deleteJob(job['_id']);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'delete', child: Text("Delete")),
                  ],
                )
              ],
            ),

            SizedBox(height: 6),

            Text(
              job['location'] ?? "",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Applicants: ${job['applicants'] ?? 0}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    job['status'] ?? "Active",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}