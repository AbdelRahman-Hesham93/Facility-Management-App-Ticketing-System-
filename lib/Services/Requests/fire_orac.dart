import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ORARequests extends StatefulWidget {
  const ORARequests({Key? key}) : super(key: key);

  @override
  State<ORARequests> createState() => _ORARequestsState();
  
}


class _ORARequestsState extends State<ORARequests> {
  
  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

    return Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('OracleRequests')
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
                  DataColumn(label: Text('Req. Type')),
                  DataColumn(label: Text('Req.')),
                  DataColumn(label: Text('Floor')),
                  DataColumn(label: Text('Phone no.')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Submit Date')),
                ],
                rows: documents.asMap().entries.map<DataRow>((entry) {
                  final data = entry.value.data();
                  final reqType = data['Request Type']?.toString() ?? 'N/A';
                  final req = data['Request']?.toString() ?? 'N/A';
                  final floor = data['Floor']?.toString() ?? 'N/A';
                  final phone = data['Phone no.']?.toString() ?? 'N/A';
                  final sta = data['Status']?.toString() ?? 'N/A';
                   final sub = data['SubmitDate']?.toString() ?? 'N/A';
                  final rowIndex = entry.key + 1;

                  return DataRow(
                   color: sta == 'Approved' ? MaterialStateColor.resolveWith((states) => Colors.green) : sta == 'Rejected' ? MaterialStateColor.resolveWith((states) => Colors.red) : null,
                    cells: [
                    DataCell(Text(rowIndex.toString())),
                    DataCell(Text(reqType)),
                     DataCell(Text(req)),
                     DataCell(Text(floor)),
                    DataCell(Text(phone)),
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