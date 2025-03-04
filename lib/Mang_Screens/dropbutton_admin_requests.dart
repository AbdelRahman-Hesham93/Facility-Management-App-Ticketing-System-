import 'package:flutter/material.dart';
import 'package:sam_app/Mang_Screens/man_ora.dart';
import 'package:sam_app/Mang_Screens/man_it.dart';

class ADropdownButtons extends StatefulWidget {
  const ADropdownButtons({Key? key}) : super(key: key);

  @override
  _ADropdownButtonsState createState() => _ADropdownButtonsState();
}

class _ADropdownButtonsState extends State<ADropdownButtons> {
  final List<String> items = [
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
            'View All Requests',
            style: TextStyle(
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

          if (selectedValue == 'IT Requests') const AdminIT(),
            if (selectedValue == 'Oracle Requests') const AdminORA(),


          // You can add similar conditions for other requests
        ],
      );
    
  }
}



 