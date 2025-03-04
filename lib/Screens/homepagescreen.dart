import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:sam_app/Auth/auth_login.dart';
import 'package:sam_app/Mang_Screens/man_req.dart';
import 'package:sam_app/Screens/catalogcard.dart';
import 'package:sam_app/Screens/chat_page.dart';
import 'package:sam_app/Screens/items.dart';
import 'package:sam_app/globalvar.dart';


class HomePageS extends StatefulWidget {
  HomePageS({Key? key}) : super(key: key);
  final AuthCode _authCode = AuthCode();

  @override
  _HomePageSState createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
 

  @override
  Widget build(BuildContext context) {
    final User? user = widget._authCode.user;
    final userDisplayName = user?.displayName ?? 'User';
    final firstName = userDisplayName.split(' ')[0];
    final String? photoUrl = user?.photoURL;


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 216, 197),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        leading: Image.asset(
          "assets/images/A.png",
          width: 15,
          height: 15,
        ),
        actions: [
          IconButton(onPressed: (){},icon: const Icon(Icons.notifications_active_outlined),),
          PopupMenuButton<int>(
            shadowColor: const Color.fromARGB(255, 10, 27, 4),
            surfaceTintColor: mainColor,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.logout_sharp, color: Color.fromRGBO(76, 143, 78, 1,),),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout", style: TextStyle(color: Color.fromRGBO(76, 143, 78, 1),fontSize: 18)),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 100),
            color: Colors.white,
            elevation: 1,
            onSelected: (value) {
              if (value == 1) {
                widget._authCode.signOutAndReauthenticate();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              color: mainColor,
              margin: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        photoUrl ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/A.png');
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "Welcome $firstName",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...mainHome.map((e) => CatalogCard(catalogItem: e)).toList(),
            const SizedBox(height: 15),
          ElevatedButton.icon(
           style: ElevatedButton.styleFrom(
         elevation: 0,
           backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30),
              ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
            ),

            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManRequests(),
                  ),
                );},  
                 icon: const Icon(Icons.assignment_outlined),
                     label: const Text('Employee Requests'),
                     
                              ),
                          
         ],
         
        ),

      ),
        //    floatingActionButton: FloatingActionButton.extended(
        //  foregroundColor: Colors.black,
        //    onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const ManRequests(),
        //           ),
        //         );},  
        //          icon: const Icon(Icons.assignment_outlined),
        //              label: const Text('Employee Requests'),
        //                       ),
                               floatingActionButtonLocation: ExpandableFab.location,
  floatingActionButton: ExpandableFab(
    openButtonBuilder: RotateFloatingActionButtonBuilder(
    child: const Icon(Icons.wechat_rounded),
    fabSize: ExpandableFabSize.regular,

    backgroundColor: const Color.fromRGBO(76, 143, 78, 0.3),
    shape: const CircleBorder(),
    ),
    children: [
      FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.desktop_windows_sharp),
        onPressed: () {},
      ),
      FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.code_off_rounded),
        onPressed: () {},
      ),
      FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.home_work_outlined),
        onPressed: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ChatPage(),
                  ),
                );
        },
      ),
    ],
  ),
    );
  }
}
