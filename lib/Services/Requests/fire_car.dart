import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarRequests extends StatefulWidget {
  const CarRequests({Key? key}) : super(key: key);

  @override
  State<CarRequests> createState() => _CarRequestsState();
}

class _CarRequestsState extends State<CarRequests> {
  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    return Center(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('CarRequests')
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
                columnSpacing: 50.0,
                columns: const [
                  DataColumn(label: Text('No.')),
                  DataColumn(label: Text('Destination')),
                  DataColumn(label: Text('Choose Date')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Phone no.')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Submit Date')),
                ],
                rows: documents.asMap().entries.map<DataRow>((entry) {
                  final data = entry.value.data();
                  final destination = data['Destination']?.toString() ?? 'N/A';
                  final chooseDate = data['Choose Date']?.toString() ?? 'N/A';
                  final phone = data['Phone no.']?.toString() ?? 'N/A';
                  final chooseTime = data['Choose Time']?.toString() ?? 'N/A';
                  final sta = data['Status']?.toString() ?? 'N/A';
                  final sub = data['SubmitDate']?.toString() ?? 'N/A';
                  final rowIndex = entry.key + 1;

                  return DataRow(
                   color: sta == 'Approved' ? MaterialStateColor.resolveWith((states) => Colors.green) : sta == 'Rejected' ? MaterialStateColor.resolveWith((states) => Colors.red) : null,
                    cells: [
                    DataCell(Text(rowIndex.toString())),
                    DataCell(Text(destination)),
                    DataCell(Text(chooseDate)),
                    DataCell(Text(chooseTime)),
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
