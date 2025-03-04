import 'package:flutter/material.dart';
import 'package:sam_app/Services/Facility/googlemap.dart';
import 'package:sam_app/Services/IT/itservice.dart';
import 'package:sam_app/Services/Facility/meetingrequest.dart';
import 'package:sam_app/Services/Facility/myresturant.dart';
import 'package:sam_app/Services/Facility/poolrequest.dart';
import 'package:sam_app/Screens/screenserv.dart';
import 'package:sam_app/Screens/screenservit.dart';
import 'package:sam_app/Services/IT/oraservice.dart';
import 'package:sam_app/Services/Facility/eventserv.dart';
import 'package:sam_app/Services/Facility/house_keeping.dart';
import 'package:sam_app/Services/Facility/mainserv.dart';
import 'package:sam_app/globalvar.dart';
import 'items.dart';

class CatalogCard extends StatelessWidget {
   const CatalogCard({super.key, required this.catalogItem, });

  final MenuItemModel catalogItem;
  
  @override
  Widget build(BuildContext context) {
  
    return 
    Card(
    
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      child: Row(children:[ const SizedBox(width: 10),
         SizedBox(width: 70,height: 70, child: Image.network(
            catalogItem.photoUrl,
            fit: BoxFit.fill
          ),),
               
          Column(
        children: [const SizedBox(height:5),
          Text(
            catalogItem.name,
            style: TextStyle(fontSize: 22, color: mainColor, fontWeight: FontWeight.bold), 
            maxLines: 1,
          ),
          const SizedBox(height: 15),
                      Padding(
        padding:const EdgeInsetsDirectional.symmetric(),
        child:Container(
          height:3.0,
          width:290.0,
          color:mainColor,),),
           Row(
           children: [ const SizedBox(width: 140),ElevatedButton(
          style: ElevatedButton.styleFrom(
         elevation: 0,
           backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(40),
              ),
          padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
          child:   const Text('Start', style: TextStyle(fontSize: 18),),
            onPressed: (){ 
                if (catalogItem.name == 'IT Request') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ItService(),
                  ),
                );
                } else if (catalogItem.name == 'Oracle Request') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  OraService(),
                  ),
                );
              }
              else if (catalogItem.name == 'IT Services') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const Screenservit(),
                  ),
                );
              } else if (catalogItem.name == 'Facility Services') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screenserv(),
                  ),
                );
             
               } else if (catalogItem.name == 'Pool Cars') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Poolrequest(),
                  ),
                );
                
               } else if (catalogItem.name == 'Restaurant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyRestaurant(),
                  ),
                );
               } else if (catalogItem.name == 'Events') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const EventService(),
                  ),
                );
              } else if (catalogItem.name == 'Meeting Rooms') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Meetingrequest(),
                  ),
                );
                 } else if (catalogItem.name == 'Maintenance') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MainService(),
                  ),
                );
                 } else if (catalogItem.name == 'House Keeping') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HouseService(),
                  ),
                );
                } else if (catalogItem.name == 'Sam Projects') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const MyMap(),
                  ),
                );
              }
          },),]),
          
          // const SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    ]),);
  }
}