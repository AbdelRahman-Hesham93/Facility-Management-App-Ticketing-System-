import 'package:flutter/material.dart';
import 'package:sam_app/Services/Requests/fire_car.dart';
import 'package:sam_app/Services/Requests/fire_events.dart';
import 'package:sam_app/Services/Requests/fire_house.dart';
import 'package:sam_app/Services/Requests/fire_it.dart';
import 'package:sam_app/Services/Requests/fire_meet.dart';
import 'package:sam_app/Services/Requests/fire_orac.dart';
import 'package:sam_app/Services/Requests/fire_main.dart';


class DropdownButtons extends StatefulWidget {
  const DropdownButtons({Key? key}) : super(key: key);

  @override
  _DropdownButtonsState createState() => _DropdownButtonsState();
}

class _DropdownButtonsState extends State<DropdownButtons> {
  final List<String> items = [
    'Pool Cars Requests',
    'Meeting Room Requests',
    'Events Requests',
    'Maintenance Requests',
    'House Keeping Requests',
    'IT Requests',
    'Oracle Requests',
    
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
             hint: const Text(
              'View Your Requests', // Add your hint text here
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey, // Adjust the color as needed
              ),
            ),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            items: items
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
        
          if (selectedValue == 'Pool Cars Requests') const CarRequests(),
          
          if (selectedValue == 'Meeting Room Requests') const MeetingRequests(),
               
          if (selectedValue == 'IT Requests') const ITRequests(),
            if (selectedValue == 'Oracle Requests') const ORARequests(),
             if (selectedValue == 'Maintenance Requests') const MainRequests(),
                if (selectedValue == 'House Keeping Requests') const HouseRequests(),
                if (selectedValue == 'Events Requests') const EventRequests(),
          // You can add similar conditions for other requests
        ],
      );
    
  }
}
//  final response = await http.get(Uri.parse('http://192.168.1.101:5000/requests'));

