import 'package:flutter/material.dart';
import 'package:sam_app/Screens/additem2try.dart';


class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Requests")),
      body: SingleChildScrollView(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                         ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'MRequest')),
                );
                      },
                       label: const Text('Manage Maintenance Request',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.work, size: 25)),
                         ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'HRequest')),
                );
                      },
                       label: const Text('Manage Housekeeping Request',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.cleaning_services_rounded, size: 25)),
                         ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'ERequest')),
                );
                      },
                       label: const Text('Manage Event Request',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.event_available_rounded, size: 25)),
             ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'ORequest')),
                );
                      },
                       label: const Text('Manage Oracle Request',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.code_rounded, size: 25)),
 ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'IRequest')),
                );
                      },
                       label: const Text('Manage IT Request',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.computer_rounded, size: 25)),
               
          ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'Company')),
                );
                      },
                       label: const Text('Manage Companies',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.factory_rounded, size: 25)),

          ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'Dept')),
                );
                      },
                       label: const Text('Manage Departments',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.home_rounded, size: 25)),
ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'Floor')),
                );
                      },
                       label: const Text('Manage Floors',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.flood_rounded, size: 25)),
ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminDataScreen(collectionName: 'AdminEmails')),
                );
                      },
                       label: const Text('Manage Admins',style: TextStyle(fontSize: 20)), 
         icon: const Icon(Icons.person_3_rounded, size: 25)),
          ],
        ),
      ),
      ),
    );
  }
}
