import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventRequests extends StatefulWidget {
  const EventRequests({Key? key}) : super(key: key);

  @override
  State<EventRequests> createState() => _EventRequestsState();
  
}


class _EventRequestsState extends State<EventRequests> {
  
  @override
  Widget build(BuildContext context) {
 final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    return Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('EventRequests')
              .where('Email', isEqualTo: currentUserEmail)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Text('Data not available');
            }

              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;

       // Sort documents by 'SubmitDate' value in descending order
          documents.sort((a, b) {
            final String submitDateA = a['SubmitDate'] ?? '';
            final String submitDateB = b['SubmitDate'] ?? '';

            final DateTime dateA = DateTime.parse(submitDateA);
            final DateTime dateB = DateTime.parse(submitDateB);

            return dateB.compareTo(dateA); // Compare in descending order
          });

              return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: 20.0,
                columns: const [
                  DataColumn(label: Text('No.')),
                  DataColumn(label: Text('Request Type')),
                  DataColumn(label: Text('Requirments')),
                  DataColumn(label: Text('Start Date')),
                  DataColumn(label: Text('Start Time')),
                  DataColumn(label: Text('End Date')),
                  DataColumn(label: Text('End Time')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Submit Date')),
                ],
                rows: documents.asMap().entries.map<DataRow>((entry) {
                  final data = entry.value.data();
                  final reqType = data['Request Type']?.toString() ?? 'N/A';
                  final requirments = data['Requirments']?.toString() ?? 'N/A';
                  final startDate = data['Start Date']?.toString() ?? 'N/A';
                  final startTime = data['Start Time']?.toString() ?? 'N/A';
                  final endDate = data['End Date']?.toString() ?? 'N/A';
                  final endTime = data['End Time']?.toString() ?? 'N/A';
                   final sta = data['Status']?.toString() ?? 'N/A';
                   final sub = data['SubmitDate']?.toString() ?? 'N/A';
                  final rowIndex = entry.key + 1;


                  return DataRow(
                   color: sta == 'Approved' ? MaterialStateColor.resolveWith((states) => Colors.green) : sta == 'Rejected' ? MaterialStateColor.resolveWith((states) => Colors.red) : null,
                    cells: [
                    DataCell(Text(rowIndex.toString())),
                    DataCell(Text(reqType)),
                    DataCell(Text(requirments)),
                    DataCell(Text(startDate)),
                    DataCell(Text(startTime)),
                    DataCell(Text(endDate)),
                    DataCell(Text(endTime)),
                    DataCell(Text(sta)),
                    DataCell(Text(sub)),
                  ]);
                }).toList(),
              ),
              ),
            );
          },
        ),
    );
    
  }
}