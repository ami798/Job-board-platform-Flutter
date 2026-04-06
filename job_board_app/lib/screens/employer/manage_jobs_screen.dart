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
        Uri.parse("http://127.0.0.1:3000/api/jobs"),
      );

      if (response.statusCode == 200) {
        setState(() {
          jobs = jsonDecode(response.body);
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Job deleted")));
      }
    } catch (e) {
      print(e);
    }
  }

  // 🔹 FILTER HELPERS
  List get activeJobs =>
      jobs.where((j) => j['status'] == 'Active').toList();

  List get draftJobs =>
      jobs.where((j) => j['status'] == 'Draft').toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF4F6FB),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Curated Career",
              style: TextStyle(color: Colors.black)),
          actions: [
            Icon(Icons.notifications_none, color: Colors.black),
            SizedBox(width: 12)
          ],
        ),

        body: Column(
          children: [

            // 🔹 HEADER SECTION
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Manage My Jobs",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                  SizedBox(height: 6),

                  Text("Review and manage your active career listings",
                      style: TextStyle(color: Colors.grey)),

                  SizedBox(height: 15),

                  // 🔹 BUTTON
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text("+ Post New Job",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  SizedBox(height: 15),

                  // 🔹 TABS (FIGMA STYLE)
                  TabBar(
                    indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "All Jobs (${jobs.length})"),
                      Tab(text: "Active (${activeJobs.length})"),
                      Tab(text: "Drafts (${draftJobs.length})"),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 LIST AREA
            Expanded(
              child: TabBarView(
                children: [
                  _buildJobList(jobs),
                  _buildJobList(activeJobs),
                  _buildJobList(draftJobs),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 JOB LIST
  Widget _buildJobList(List data) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      return Center(child: Text("No jobs found"));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _jobCard(data[index]);
      },
    );
  }

  // 🔹 FIGMA STYLE JOB CARD
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
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 TITLE + MENU
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
                    PopupMenuItem(
                        value: 'delete', child: Text("Delete")),
                  ],
                )
              ],
            ),

            SizedBox(height: 8),

            Text(job['location'] ?? "",
                style: TextStyle(color: Colors.grey)),

            SizedBox(height: 12),

            // 🔹 STATS ROW (FIGMA STYLE)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("APPLICANTS",
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey)),
                    Text("${job['applicants'] ?? 0}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("STATUS",
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey)),
                    Text(job['status'] ?? "Active",
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}