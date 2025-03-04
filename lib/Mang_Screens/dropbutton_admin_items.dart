// import 'package:flutter/material.dart';

// import '../Screens/additem2try.dart';

// class ManageItems extends StatefulWidget {
//   const ManageItems({Key? key}) : super(key: key);

//   @override
//   _ManageItemsState createState() => _ManageItemsState();
// }

// class _ManageItemsState extends State<ManageItems> {
//   final List<String> items = [
//     'Add Maintenance Request',
//     'Add HouseKeeping Request',
//     'Add Event Request',
//     'Add IT Request',
//     'Add Oracle Request',

//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         DropdownButton<String>(
//           hint: const Text(
//             'View All Requests',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value;
//             });
//           },
//           items: items
//               .map((String item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(
//                       item,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ))
//               .toList(),
//           ),
          
//           if (selectedValue == 'Add Maintenance Request') const AdminDataScreen(collectionName: 'MRequest'),
          
//           if (selectedValue == 'Add HouseKeeping Request') const AdminDataScreen(collectionName: 'HRequest'),
              
//           if (selectedValue == 'Add Event Request') const AdminDataScreen(collectionName: 'ERequest'),
          
//             if (selectedValue == 'Add IT Request') const AdminDataScreen(collectionName: 'IRequest'),

//                 if (selectedValue == 'Add Oracle Request') const AdminDataScreen(collectionName: 'ORequest'),
//                 // if (selectedValue == 'Events Requests') const AdminEvent(),
//           // You can add similar conditions for other requests
//         ],
//       );
    
//   }
// }



 