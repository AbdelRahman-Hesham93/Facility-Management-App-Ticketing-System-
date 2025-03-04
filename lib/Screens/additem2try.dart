import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDataScreen extends StatefulWidget {
  final String collectionName;

  const AdminDataScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  _AdminDataScreenState createState() => _AdminDataScreenState();
}

class _AdminDataScreenState extends State<AdminDataScreen> {
  final TextEditingController newItemController = TextEditingController();

  Future<List<String>> fetchCollection() async {
    List<String> items = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(widget.collectionName).get();
    for (var doc in querySnapshot.docs) {
      items.add(doc['name']); // Adjust this based on your Firestore document structure
    }
    return items;
  }

  void addItem(String item) async {
    CollectionReference collRef = FirebaseFirestore.instance.collection(widget.collectionName);
    await collRef.add({'name': item});
    fetchCollection();
  }

  void deleteItem(String item) async {
    CollectionReference collRef = FirebaseFirestore.instance.collection(widget.collectionName);
    QuerySnapshot querySnapshot = await collRef.where('name', isEqualTo: item).get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    fetchCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage ${widget.collectionName}')),
      body: FutureBuilder<List<String>>(
        future: fetchCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available.');
          } else {
            List<String> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteItem(items[index]);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String newItem = '';
              return AlertDialog(
                title: const Text('Add New Request'),
                content: TextField(
                  controller: newItemController,
                  onChanged: (value) => newItem = value,
                  decoration: const InputDecoration(labelText: 'Request Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(newItem);
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );

          if (newItem != null && newItem.isNotEmpty) {
            addItem(newItem);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
