import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Screens/mytextbox.dart';
import 'package:sam_app/Screens/popup.dart';

class Poolrequest extends StatefulWidget {
  Poolrequest({Key? key}) : super(key: key);

  final GlobalKey<PoolrequestState> pickerKey =
      GlobalKey<PoolrequestState>();

  @override
  PoolrequestState createState() => PoolrequestState();
}

class PoolrequestState extends State<Poolrequest> {
  final destCont = TextEditingController();
  final exeCont = TextEditingController();
  final AuthCode _authCode = AuthCode();
 
  DateTime? selectedDate;
  String date = "-";

  TimeOfDay? selectedTime;
  String time = "-";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold( backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Pool Car Request"), centerTitle: true,
           leading: Image.asset(
          "assets/images/A.png", // Replace with the path to your image asset
          width: 15, // Adjust the width as needed
          height: 15, // Adjust the height as needed
        ),),
      body: SingleChildScrollView( scrollDirection: Axis.vertical,
     child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://iili.io/JHvibhN.png',
),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 45,
            color: Colors.grey[300],
            child: Text("Start Date: $date - Start Time: $time",style: const TextStyle(fontSize: 15)),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              child: const Text("Pick Date", style: TextStyle(color: Colors.white)),
              onPressed: () {
                showDialogPicker(context);
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              child: const Text("Pick Time", style: TextStyle(color: Colors.white)),
              onPressed: () {
                showDialogTimePicker(context);
              },
            ),
        ]), 
          const Padding(padding: EdgeInsets.symmetric(vertical:5)),
          
            MyTextBox(
              ltxt: 'Destination',
              rtxt: 'Please Enter your Destination',
              controller: destCont,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        MyTextBox(
              ltxt: 'Requester Ext./ Mobile',
              rtxt: 'Please enter your Ext./ Mobile',
              controller: exeCont,
            ),
          const Padding(padding: EdgeInsets.symmetric(vertical:5)),
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
              if (selectedDate != null && selectedTime != null) {

                CollectionReference collRef =
                    FirebaseFirestore.instance.collection('CarRequests');
                 final submitDate = DateTime.now();
                final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(submitDate);
                collRef.add({
                  'Destination': destCont.text,
                  'Phone no.': exeCont.text,
                  'Choose Date':
                      Utils.getFormattedDateSimple(selectedDate!.millisecondsSinceEpoch),
                  'Choose Time': "${selectedTime!.hour} : ${selectedTime!.minute}",
                  "Email": _authCode.user!.email,
                  "SubmitDate": formattedDateTime,
                  "User": _authCode.user!.displayName,
                  "Status": "pending",
                });
                
                const Popup().showPopUpMessage(context);
              }
            },
            label: const Text('Submit Request'),
            icon: const Icon(Icons.save, size: 40),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
        ],
      ),
      ),
    );
  }

  void showDialogPicker(BuildContext context) async {
    DateTime? value = await showDatePicker(
      context: context,
      // helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      if (value == null) return;
      selectedDate = value;
      date = Utils.getFormattedDateSimple(value.millisecondsSinceEpoch);
    });
  }

  void showDialogTimePicker(BuildContext context) async {
    TimeOfDay? value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      if (value == null) return;
      selectedTime = value;
      time = "${value.hour} : ${value.minute}";
    });
  }
}

class Utils {
  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = DateFormat("MMMM dd, yyyy");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }
}
