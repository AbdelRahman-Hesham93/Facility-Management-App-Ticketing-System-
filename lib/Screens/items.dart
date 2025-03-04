import 'package:flutter/material.dart';

class MenuItemModel {
   final String name;
  final String photoUrl;


  MenuItemModel(this.name, this.photoUrl);
}

final List<MenuItemModel> servicedesks = [
  MenuItemModel(
    'Pool Cars',
'https://iili.io/JHvibhN.png'  
  ),

    MenuItemModel(
    'Restaurant',
    'https://iili.io/JHvs9EX.png'    ),
    
  MenuItemModel(
    'Meeting Rooms',
'https://iili.io/JHvs2YG.png'
  ),

    MenuItemModel(
    'Events',
'https://iili.io/JHvsFp4.png'  
),

  MenuItemModel(
    'Maintenance',
'https://iili.io/JHviZpR.png' 
 ),

    MenuItemModel(
    'House Keeping',
'https://iili.io/JHvsoG9.png' 
 ),

  MenuItemModel(
    'Sam Projects',
'https://iili.io/JHvsqj2.png'   
 ),
];

  final List<MenuItemModel> itservicedesks = [
  MenuItemModel(
    'IT Request',
'https://iili.io/JHviQkv.png'  
  ),
  MenuItemModel(
    'Oracle Request',
    
'https://iili.io/JHviyBt.png'  ),

  ];
  
    final List<MenuItemModel> mainHome = [
  MenuItemModel(
    'IT Services',
    
'https://iili.io/JHviDIp.png'
  ),
  MenuItemModel(
    'Facility Services',
    
'https://iili.io/JHvsqj2.png'  ),

  ];

class PoolCarRequest {
  final String destination;
  final DateTime date;
  final TimeOfDay time;

  PoolCarRequest({
    required this.destination,
    required this.date,
    required this.time,
  });
}
class CarItem {
  final String destination;
  final DateTime date;
  final TimeOfDay time;

  CarItem({
    required this.destination,
    required this.date,
    required this.time,
  });
}

class MeetItem {
  final String noofattendance;
  final DateTime date;
  final TimeOfDay time;

  MeetItem({
    required this.noofattendance,
    required this.date,
    required this.time,
  });
}