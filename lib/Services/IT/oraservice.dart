import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Screens/mytextbox.dart';
import 'package:sam_app/Screens/popup.dart';
import 'package:sam_app/globalvar.dart';


class OraService extends StatelessWidget {
   OraService({Key? key}) : super(key: key);
  final reqCont = TextEditingController();
  final AuthCode _authCode = AuthCode();
  final exeCont = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Oracle Service Request"), centerTitle: true,
             leading: Image.asset(
          "assets/images/A.png", // Replace with the path to your image asset
          width: 15, // Adjust the width as needed
          height: 15, )),
           body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://iili.io/JHviyBt.png',
),
              ),
              DropdownButtons(
                collectionName: 'OREQUESTS',
                hintText: 'Choose your request',
                onChanged: (value) {
                  // Handle selected request type
                  selectedRequestType = value;
                },
              ),
              DropdownButtons(
                collectionName: 'DEPARTMENT',
                hintText: 'Choose your Department',
                onChanged: (value) {
                  // Handle selected floor
                  selectedDept = value;
                },
              ),
              DropdownButtons(
                collectionName: 'FLOOR',
                hintText: 'Choose your floor',
                onChanged: (value) {
                  // Handle selected floor
                  selectedFloor = value;
                },
              ),
              // const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
  final submitDate = DateTime.now();
  final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(submitDate);

  final requestData = {
    'Request': reqCont.text,
    'RequestType': selectedRequestType,
    'PhoneNo': exeCont.text,
    'Dept': selectedDept,
    'Floor': selectedFloor,
    'Email': _authCode.user!.email,
    'SubmitDate': formattedDateTime,
    'User': _authCode.user!.displayName,
    'Status': 'Pending',
  };

  final response = await http.post(
    Uri.parse('$url/submitOrarequest'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
  
    const Popup().showPopUpMessage(context);
  } else {
    // Request failed
    print('Request failed with status: ${response.statusCode}');
  }
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
    // Initialize the dropdownItems to an empty list.
    fetchDropdownItems();
  }

  Future<void> fetchDropdownItems() async {
    final response = await http.get(Uri.parse('$url/requests'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        final List<dynamic> rows = data['rows'];
       if (widget.collectionName == 'OREQUESTS') {
        dropdownItems = rows
            .where((item) => item['IT_REQUESTS'] != null)
            .map((item) => item['IT_REQUESTS'].toString())
            .toList();
      } else if (widget.collectionName == 'DEPARTMENT') {
        dropdownItems = rows
            .where((item) => item['DEPARTMENT'] != null)
            .map((item) => item['DEPARTMENT'].toString())
            .toList();
      } else if (widget.collectionName == 'FLOOR') {
        dropdownItems = rows
            .where((item) => item['FLOOR'] != null)
            .map((item) => item['FLOOR'].toString())
            .toList();
      }
      });
    } else {
      throw Exception('Failed to load data');
    }
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
