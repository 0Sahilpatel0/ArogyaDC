// // import 'package:docu/widgets/chat_user_card.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// //
// // import '../api/apis.dart';
// // import '../main.dart';
// // import '../models/chat_user.dart';
// //
// //
// //
// // class HomeS extends StatefulWidget {
// //   const HomeS({super.key});
// //
// //   @override
// //   State<HomeS> createState() => _HomeSState();
// // }
// //
// // class _HomeSState extends State<HomeS> {
// //
// //
// //   List<ChatUser> list = [];
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //
// //       appBar: AppBar(
// //
// //         leading: Padding(
// //           padding: const EdgeInsets.only(top: 10),
// //           child: Icon(CupertinoIcons.home),
// //         ),
// //         iconTheme: IconThemeData(color: Colors.white),
// //         actions: [
// //           Padding(
// //             padding: const EdgeInsets.only(top: 10),
// //             child: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.only(top: 10),
// //             child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
// //           )
// //
// //         ],
// //         centerTitle: true,
// //         elevation: 1,
// //         title: Text ("Docu Care"  ,
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontWeight: FontWeight.normal,
// //           fontSize: 20
// //         )),
// //         backgroundColor: Colors.green,
// //       ),
// //
// //
// //       floatingActionButton: Padding(
// //         padding: const EdgeInsets.only(bottom: 65 , right: 15),
// //
// //         child: FloatingActionButton(
// //           onPressed: () async {
// //
// //               await APIs.auth.signOut();
// //               await GoogleSignIn().signOut();
// //           },child: Icon(Icons.add_comment_rounded, color: Colors.white,) , backgroundColor: Colors.green  ,
// //
// //         ),
// //       ),
// //
// //       body: StreamBuilder(
// //         builder: (context , snapshot) {
// //
// //
// //
// //           switch (snapshot.connectionState) {
// //
// //             case ConnectionState.waiting:
// //             case ConnectionState.none:
// //
// //
// //
// //               return Center(child: CircularProgressIndicator());
// //
// //
// //
// //
// //             case ConnectionState.active:
// //             case ConnectionState.done:
// //
// //
// //
// //             final data = snapshot.data?.docs;
// //
// //             list = data?.map((e) => ChatUser.fromJson(e.data())).toJson() ?? [];
// //
// //
// //
// //
// //             return ListView.builder(
// //               itemCount: list.length,
// //               padding: EdgeInsets.only(top: mq.height * .01),
// //               physics: BouncingScrollPhysics(),
// //               itemBuilder: (context, index) {
// //
// //
// //                 return ChatUserCard(user: list[index] );
// //
// //                 // return Text('Name: ${list[index]}');
// //               },
// //             ); stream: APIs.firestore.collection('user').snapshots(),
// //           ),
// //
// //
// //
// //
// //
// //           },
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //     );
// //   }
// // }
//
//
//
//
//

//
// import 'package:docu/Screens/profile_s.dart';
// import 'package:docu/widgets/chat_user_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../api/apis.dart';
// import '../main.dart';
// import '../models/chat_user.dart';
//
// class HomeS extends StatefulWidget {
//   const HomeS({Key? key}) : super(key: key);
//
//   @override
//   State<HomeS> createState() => _HomeSState();
// }
//
// class _HomeSState extends State<HomeS> {
//   List<ChatUser> _list = [];
//
//   List<ChatUser> _searchList = [];
//
//   bool _isSearching = false;
//
//   @override
//   void initState(){
//     super.initState();
//     APIs.getSelfInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Icon(CupertinoIcons.home),
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _isSearching = !_isSearching;
//                   });
//                 },
//                 icon: Icon(_isSearching
//                     ? CupertinoIcons.clear_circled_solid
//                     : Icons.search)),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: IconButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreens(user: APIs.me)));
//             }, icon: Icon(Icons.more_vert)),
//           ),
//         ],
//         centerTitle: true,
//         elevation: 1,
//         title: _isSearching
//             ?  TextField(
//             decoration: InputDecoration(
//               border: InputDecoration(border: InputBorder.none , hintText: 'Name , Email, ....'),
//             autofocus: true,
//           )
//
//         ) :  Text(
//           "Docu Care",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           ),
//         ),
//         backgroundColor: Colors.green,
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 65, right: 15),
//         child: FloatingActionButton(
//           onPressed: () async {
//             await APIs.auth.signOut();
//             await GoogleSignIn().signOut();
//           },
//           child: Icon(Icons.add_comment_rounded, color: Colors.white),
//           backgroundColor: Colors.green,
//         ),
//       ),
//       body: StreamBuilder(
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//             case ConnectionState.none:
//               return Center(child: CircularProgressIndicator());
//             case ConnectionState.active:
//             case ConnectionState.done:
//                 final data = snapshot.data!.docs;
//                 _list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
//                 if (_list.isNotEmpty)
//                   {
//                     return ListView.builder(
//                       itemCount: _list.length,
//                       padding: EdgeInsets.only(top: mq.height * .01),
//                       physics: BouncingScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return ChatUserCard(user: _list[index]);
//                       },
//                     );
//                   }else
//                     {
//
//                       return Center(child: Text('No Connection Found' , style: TextStyle(fontSize: 20)));
//
//                     }
//                   default:
//                     return Center(
//                         child: Text('Unexpected ConnectionState: ${snapshot.connectionState}'));
//           }
//         },
//         stream: APIs.getAllUsers()
//       ),
//     );
//   }
// }
//






























import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docu/Screens/profile_s.dart';
import 'package:docu/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';

class HomeS extends StatefulWidget {
  const HomeS({Key? key}) : super(key: key);

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  List<ChatUser> _list = [];
  List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if (_isSearching){
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);

          } else {
            return Future.value(true);

          }

        },
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(CupertinoIcons.home),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileScreens(user: APIs.me)),
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 1,
            title: _isSearching
                ? TextField(
              decoration: InputDecoration(
                hintText: 'Name, Email, ...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              autofocus: true,
              style: TextStyle(fontSize: 17 , letterSpacing: 0.5),


              onChanged: (val)
                {

                  _searchList.clear();

                  for (var i in _list) {

                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                    i.email.toLowerCase().contains(val.toLowerCase()) ) {

                      _searchList.add(i);

                    }
                    setState(() {
                    _searchList;
                    });

                    }

                }










            )
                : Text(
              "ArogyaDC",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.green,
          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 65, right: 15),
            child: FloatingActionButton(
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              },
              child: Icon(Icons.add_comment_rounded, color: Colors.white),
              backgroundColor: Colors.green,
            ),
          ),



          body: StreamBuilder(
            builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data!.docs;
              _list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              if (_list.isNotEmpty)
              {
                return ListView.builder(
                  itemCount: _isSearching ? _searchList.length : _list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                        user:

                            _isSearching ? _searchList[index] : _list[index]);
                  },
                );
              }else
              {

                return Center(child: Text('No Connection Found' , style: TextStyle(fontSize: 20)));

              }
            default:
              return Center(
                  child: Text('Unexpected ConnectionState: ${snapshot.connectionState}'));
          }
        },
        stream: APIs.getAllUsers()
        ),
        ),
      ),
    );
  }
}










