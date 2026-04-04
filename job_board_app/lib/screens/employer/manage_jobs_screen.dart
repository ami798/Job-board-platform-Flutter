import 'package:flutter/material.dart';

class ManageJobsScreen extends StatelessWidget {
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

  Widget _buildJobList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _jobCard(
          title: "Senior Product Designer",
          applicants: "48",
          status: "Active",
          location: "Remote",
        ),
        _jobCard(
          title: "Marketing Director",
          applicants: "156",
          status: "Closed",
          location: "New York, US",
        ),
        _jobCard(
          title: "Backend Engineer",
          applicants: "5",
          status: "New",
          location: "Berlin, DE",
        ),
      ],
    );
  }

  Widget _jobCard({
    required String title,
    required String applicants,
    required String status,
    required String location,
  }) {
    Color statusColor;

    switch (status) {
      case "Active":
        statusColor = Colors.green;
        break;
      case "Closed":
        statusColor = Colors.red;
        break;
      default:
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

          // TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(child: Text("Edit")),
                  PopupMenuItem(child: Text("Delete")),
                ],
              )
            ],
          ),

          SizedBox(height: 6),

          Text(location, style: TextStyle(color: Colors.grey)),

          SizedBox(height: 10),

          // BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("$applicants Applicants",
                  style: TextStyle(fontWeight: FontWeight.w500)),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}