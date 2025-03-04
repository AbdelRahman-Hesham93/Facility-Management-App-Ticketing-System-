import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Screens/mytextbox.dart';
import 'package:sam_app/Screens/popup.dart';

class Meetingrequest extends StatefulWidget {
  const Meetingrequest({Key? key}) : super(key: key);

  @override
  MeetingrequestState createState() => MeetingrequestState();
}

class MeetingrequestState extends State<Meetingrequest> {
  final atteCont = TextEditingController();
   final exeCont = TextEditingController();

  final AuthCode _authCode = AuthCode();

  DateTime? startSelectedDate;
  String startDate = "-";

  TimeOfDay? startSelectedTime;
  String startTime = "-";

  DateTime? endSelectedDate;
  String endDate = "-";

  TimeOfDay? endSelectedTime;
  String endTime = "-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: true,
      appBar:
          AppBar(title: const Text("Meeting Room Request"), centerTitle: true,
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
            backgroundImage: NetworkImage('https://iili.io/JHvs2YG.png',
),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
           DropdownButtons(
                collectionName: 'Food',
                hintText: 'Choose Food & Beverage',
                onChanged: (value) {
                  // Handle selected floor
                  selectedRequestType = value;
                },
              ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 90, // Increased height to fit both date and time
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Start Date: $startDate - Start Time: $startTime",style: const TextStyle(fontSize: 15)),
                Text("End Date: $endDate - End Time: $endTime",style: const TextStyle(fontSize: 15)),
        ]),
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
                child:
                    const Text("Start Date", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialogPicker(context, true);
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),
                child:
                    const Text("Start Time", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialogTimePicker(context, true);
                },
              ),
            ],
          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                ),
                child:
                    const Text("End Date", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialogPicker(context, false);
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                ),
                child:
                    const Text("End Time", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialogTimePicker(context, false);
                },
              ),
            ],
          ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),

            MyTextBox(
              ltxt: 'Number of Attendees',
              rtxt: 'Please enter number of attendees',
              controller: atteCont,
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
              if (startSelectedDate != null &&
                  startSelectedTime != null &&
                  endSelectedDate != null &&
                  endSelectedTime != null) {
                CollectionReference collRef =
                    FirebaseFirestore.instance.collection('MeetingRequests');
                   final submitDate = DateTime.now();
                final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(submitDate);
                collRef.add({
                  'Attendees': atteCont.text,
                   'Phone no.': exeCont.text,
                  'Food & Beverage' : selectedRequestType,
                  'Start Date':
                      Utils.getFormattedDateSimple(startSelectedDate!.millisecondsSinceEpoch),
                  'Start Time': "${startSelectedTime!.hour} : ${startSelectedTime!.minute}",
                  'End Date':
                      Utils.getFormattedDateSimple(endSelectedDate!.millisecondsSinceEpoch),
                  'End Time': "${endSelectedTime!.hour} : ${endSelectedTime!.minute}",
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
          // const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
        ],
      ),
    ),
    );
  }

  void showDialogPicker(BuildContext context, bool isStartDate) async {
    DateTime? value = await showDatePicker(
      context: context,
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
      if (isStartDate) {
        startSelectedDate = value;
        startDate = Utils.getFormattedDateSimple(value.millisecondsSinceEpoch);
      } else {
        endSelectedDate = value;
        endDate = Utils.getFormattedDateSimple(value.millisecondsSinceEpoch);
      }
    });
  }

  void showDialogTimePicker(BuildContext context, bool isStartTime) async {
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
      if (isStartTime) {
        startSelectedTime = value;
        startTime = "${value.hour} : ${value.minute}";
      } else {
        endSelectedTime = value;
        endTime = "${value.hour} : ${value.minute}";
      }
    });
  }
}

class Utils {
  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = DateFormat("MMMM dd, yyyy");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
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
    // dropdownItems = await const EventService().fetchCollection(widget.collectionName);
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
