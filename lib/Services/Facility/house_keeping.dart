import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Screens/mytextbox.dart';
import 'package:sam_app/Screens/popup.dart';

class HouseService extends StatelessWidget {
  HouseService({Key? key}) : super(key: key);
  final reqCont = TextEditingController();
  final exeCont = TextEditingController();
  final AuthCode _authCode = AuthCode();

Future<List<String>> fetchCollection(String collectionName) async {
    List<String> items = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    for (var doc in querySnapshot.docs) {
      items.add(doc['name']); // Adjust this based on your Firestore document structure
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("House Keeping Request"), centerTitle: true,
           leading: Image.asset(
          "assets/images/A.png", // Replace with the path to your image asset
          width: 15, // Adjust the width as needed
          height: 15, // Adjust the height as needed
        ),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://iili.io/JHvsoG9.png'
),
            ),
            DropdownButtons(
              collectionName: 'HRequest',
              hintText: 'Choose your request',
              onChanged: (value) {
                selectedRequestType = value;
              },
            ),
            DropdownButtons(
              collectionName: 'Company',
              hintText: 'Choose your Company',
              onChanged: (value) {
                selectedComp = value;
              },
            ),
            DropdownButtons(
              collectionName: 'Dept',
              hintText: 'Choose your Department',
              onChanged: (value) {
                selectedDept = value;
              },
            ),
            DropdownButtons(
              collectionName: 'Floor',
              hintText: 'Choose your floor',
              onChanged: (value) {
                selectedFloor = value;
              },
            ),
            MyTextBox(
              ltxt: 'Request',
              rtxt: 'Please enter your Request',
              controller: reqCont,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            MyTextBox(
              ltxt: 'Requester Ext./ Mobile',
              rtxt: 'Please enter your Ext./ Mobile',
              controller: exeCont,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              onPressed: () async {
                CollectionReference collRef =
                    FirebaseFirestore.instance.collection('HouseRequests');
                final submitDate = DateTime.now();
                final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(submitDate);

                await collRef.add({
                  'Request': reqCont.text,
                  'Request_type': selectedRequestType,
                  'Phone_no': exeCont.text,
                  'Comp': selectedComp,
                  'Dept': selectedDept,
                  'Floor': selectedFloor,
                  "Email": _authCode.user!.email,
                  "SubmitDate": formattedDateTime,
                  "User": _authCode.user!.displayName,
                  "Status": "pending", // Set the initial status to pending
                });
                const Popup().showPopUpMessage(context);
               
              },
              label: const Text('Submit Request'),
              icon: const Icon(Icons.save, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtons extends StatefulWidget {
  final String collectionName;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const DropdownButtons({
    Key? key,
    required this.collectionName,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownButtonsState createState() => _DropdownButtonsState();
}

class _DropdownButtonsState extends State<DropdownButtons> {
  String? selectedValue;
  List<String> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    fetchDropdownItems();
  }

  Future<void> fetchDropdownItems() async {
    dropdownItems = await HouseService().fetchCollection(widget.collectionName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          hint: Text(
            widget.hintText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value);
          },
          items: dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

String? selectedRequestType;
String? selectedFloor;
String? selectedComp;
String? selectedDept;
