import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminORA extends StatefulWidget {
  const AdminORA ({Key? key}) : super(key: key);

  @override
  State<AdminORA> createState() => _AdminORAState();
  
}
class _AdminORAState extends State<AdminORA> {
  
   @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('OracleRequests').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20.0,
                    columns: const [
                     DataColumn(label: Text('No.')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Submit Date')),
                     DataColumn(label: Text('Req. Type')),
                     DataColumn(label: Text('Phone no.')),
                     DataColumn(label: Text('Floor')),
                     DataColumn(label: Text('Req.')),
                      DataColumn(label: Text('Status')),
                     DataColumn(label: Text('Action')),
                ],
                rows: documents.asMap().entries.map<DataRow>((entry) {
                  final data = entry.value.data();
                  final reqType = data['Request Type']?.toString() ?? 'N/A';
                  final floor = data['Floor']?.toString() ?? 'N/A';
                  final phone = data['Phone no.']?.toString() ?? 'N/A';
                  final req = data['Request']?.toString() ?? 'N/A';
                  final name = data['User']?.toString() ?? 'N/A';
                  final email = data['Email']?.toString() ?? 'N/A';
                  final sumbitDate = data['SubmitDate']?.toString() ?? 'N/A';
                  var status = data['Status']?.toString() ?? 'Pending';
                  final rowIndex = entry.key + 1;

                  return DataRow(
                   color: status == 'Approved' ? MaterialStateColor.resolveWith((states) => Colors.green) : status == 'Rejected' ? MaterialStateColor.resolveWith((states) => Colors.red) : null,
                    cells: [
                    DataCell(Text(rowIndex.toString())),
                    DataCell(Text(name)),
                    DataCell(Text(email)),
                     DataCell(Text(sumbitDate)),
                    DataCell(Text(reqType)),
                    DataCell(Text(phone)),
                    DataCell(Text(floor)),
                    DataCell(Text(req)),
                     DataCell(Text(status)),
                         DataCell(Row( children :[
                          ElevatedButton( style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                            ),
                           padding: const EdgeInsets.symmetric(horizontal: 30),),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('CarRequests').doc(entry.value.id).update({
                                'Status': 'Approved',
                              }).then((_) {
                                setState(() {
                                  status = 'Approved';
                                });
                              }).catchError((error) {
                                print('Error updating status: $error');
                              });
                            },
                            child: const Text('Approve'),
                            ),
                            ElevatedButton( style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                            ),
                           padding: const EdgeInsets.symmetric(horizontal: 30),),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('CarRequests').doc(entry.value.id).update({
                                'Status': 'Rejected',
                              }).then((_) {
                                setState(() {
                                  status = 'Rejected';
                                });
                              }).catchError((error) {
                                print('Error updating status: $error');
                              });
                            },
                            child: const Text('Reject'),
                          ),
                          ],
                          ),
                        ),
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