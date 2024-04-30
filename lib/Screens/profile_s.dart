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
//
// import 'dart:html';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:docu/Screens/Auth/logins.dart';
// import 'package:docu/helper/dialoge.dart';
// import 'package:docu/widgets/chat_user_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../api/apis.dart';
// import '../main.dart';
// import '../models/chat_user.dart';
//
// class ProfileScreens extends StatefulWidget {
//
//   final ChatUser user;
//
//   const ProfileScreens({super.key, required this.user});
//
//
//   @override
//   State<ProfileScreens> createState() => _ProfileScreensState();
// }
//
// class _ProfileScreensState extends State<ProfileScreens> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   String? _image;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//
//           centerTitle: true,
//           elevation: 1,
//           title: Text(
//             "Profile Screen",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//               fontSize: 20,
//             ),
//           ),
//           backgroundColor: Colors.green,
//         ),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 65, right: 15),
//           child: FloatingActionButton.extended(
//             onPressed: () async {
//
//               Dialogs.showProgressBar(context);
//
//               await APIs.auth.signOut().then((value) async {
//
//                 await GoogleSignIn().signOut().then((value) {
//                   Navigator.pop(context);
//
//                   Navigator.pop(context);
//
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>LoginS()));
//                 });
//
//
//               });
//
//             },
//             icon: Icon(Icons.logout, color: Colors.white) ,  label: Text('Log out' , style: TextStyle(color: Colors.white),),
//             backgroundColor: Colors.green,
//           ),
//         ),
//         body: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 SizedBox(
//                     width: mq.width, height: mq.height * .03
//                 ),
//                 Stack(
//                   children: [
//
//                     _image != null?
//                 ClipRRect(
//                         borderRadius: BorderRadius.circular(mq.height * .1),
//                           child: Image.file( File(_image!),
//                             width: mq.height * .2,
//                             height: mq.height * .2,
//                             fit: BoxFit.fill ),
//
//
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(mq.height * .1),
//                   child: ChatUserCard(
//                     width: mq.height * .2,
//                     height: mq.height * .2,
//                     fit : BoxFit,
//                     imageUrl : widget.user.image,
//                     errorWidget: (context , url , error ) =>
//                          CircleAvatar(
//                            child: Icon(CupertinoIcons.person)),
//                   ),
//                 )
//
//                             )
//                           ):
//
//
//                     Positioned(
//
//                       bottom: 0,
//                       right: 0,
//                       child: MaterialButton(
//                         elevation: 5,
//                           onPressed: () {
//                             _showBottomSheet();
//                           } ,
//                           shape: CircleBorder(),
//                           color: Colors.white,
//                           child: Icon(Icons.edit , color: Colors.blue,) ),
//                     )
//
//
//
//                   ],
//                 ),
//
//                 SizedBox(
//                      height: mq.height * .03
//                 ),
//
//                 Text(widget.user.email,style: TextStyle(color: Colors.black54 , fontSize: 16 )),
//
//                 SizedBox(
//                     height: mq.height * .03
//                 ) ,
//
//                 TextFormField( initialValue: widget.user.name,
//
//                   onSaved: (val) => APIs.me.name = val ?? '',
//
//                   validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field' ,
//
//                   decoration: InputDecoration(
//
//                     prefixIcon: Icon(Icons.person ,  color: Colors.green,) ,
//
//
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//
//                       hintText: 'Profile Name', label: Text('Name'),
//
//
//                   ),
//
//                 ),
//
//                 SizedBox(
//                     height: mq.height * .03
//                 ) ,
//
//
//                 TextFormField( initialValue: widget.user.about,
//
//                   onSaved: (val) => APIs.me.about = val ?? '',
//
//                   validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field' ,
//
//                   decoration: InputDecoration(
//
//                     prefixIcon: Icon(Icons.info_outline , color: Colors.green,) ,
//
//
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//
//                     hintText: 'Write about you', label: Text('about'),
//
//
//                   ),
//
//                 ),
//
//                 SizedBox(
//                     height: mq.height * .05
//                 ) ,
//
//
//                 ElevatedButton.icon(
//
//                   style: ElevatedButton.styleFrom(shape: StadiumBorder() , minimumSize: Size(mq.width * .4 , mq.height* .055) , backgroundColor: Colors.white ),
//
//
//
//                   onPressed: () {
//
//                     if(_formKey.currentState!.validate())
//                       {
//                         _formKey.currentState!.save();
//                         // print('insted validator');
//
//                         APIs.updateUserInfo().then((value) {
//                           Dialogs.showSnackbar(
//                             context, 'Profile is Updated Sucessfully'
//                           );
//                         });
//                       }
//
//                   },
//
//                   icon: Icon(Icons.edit) , label: Text('Update'),)
//
//
//
//
//               ],),
//             ),
//           ),
//         )
//       ),
//     );
//   }
//
//
//   void _showBottomSheet () {
//     showModalBottomSheet(
//         context: context,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         builder: (_){
//           return ListView(
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: mq.height * .05 , bottom: mq.height * .05),
//             children: [
//               Text('Pick Profile Picture' , textAlign: TextAlign.center,
//                 style: TextStyle(fontSize:20 , fontWeight: FontWeight.w900 ),),
//
//               SizedBox(height: mq.height * .02),
//
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       fixedSize: Size(mq.width * .3 , mq.height * .15),
//                     ),
//
//                       onPressed: () async {
//                         final ImagePicker picker = ImagePicker();
// // Pick an image.
//                         final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//                         if (image != null)
//                           {
//                             print ('IMage Path: ${image.path} -- MimeType: ${image.mimeType}');
//                             Navigator.pop(context);
//                           }
//
//                       }, child: Image.asset('images/document.png')),
//
//
//                   ElevatedButton(
//
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         fixedSize: Size(mq.width * .3 , mq.height * .15),
//
//                       ),
//
//                       onPressed: (){}, child: Image.asset('images/document.png')),
//                 ],
//               ),
//
//
//
//
//
//             ],
//           );
//         });
//   }
//
//
//
//
// }










import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:docu/Screens/Auth/logins.dart';
import 'package:docu/helper/dialoge.dart';
import 'package:docu/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';

class ProfileScreens extends StatefulWidget {
  final ChatUser user;

  const ProfileScreens({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final _formKey = GlobalKey<FormState>();

  String? _image;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text(
            "Profile Screen",
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
          child: FloatingActionButton.extended(
            onPressed: () async {
              Dialogs.showProgressBar(context);

              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginS()));
                });
              });
            },
            icon: Icon(Icons.logout, color: Colors.white),
            label: Text('Log out', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: mq.size.width, height: mq.size.height * .03),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(mq.size.height * .1),
                        child: Image.file(
                          File(_image!),
                          width: mq.size.height * .2,
                          height: mq.size.height * .2,
                          fit: BoxFit.cover,
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(mq.size.height * .1),
                        child: CachedNetworkImage(
                          width: mq.size.height * .2,
                          height: mq.size.height * .2,
                          fit: BoxFit.cover,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: CircleBorder(),
                          color: Colors.white,
                          child: Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.size.height * .03),
                  Text(widget.user.email, style: TextStyle(color: Colors.black54, fontSize: 16)),
                  SizedBox(height: mq.size.height * .03),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Profile Name',
                      label: Text('Name'),
                    ),
                  ),
                  SizedBox(height: mq.size.height * .03),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Write about you',
                      label: Text('about'),
                    ),
                  ),
                  SizedBox(height: mq.size.height * .05),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.size.width * .4, mq.size.height * .055),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(context, 'Profile is Updated Sucessfully');
                        });
                      }
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    final mq = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: mq.size.height * .05, bottom: mq.size.height * .05),
          children: [
            Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: mq.size.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(mq.size.width * .3, mq.size.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery );
                    if (image != null) {
                      print('Image Path: ${image.path} -- MimeType: ${image.mimeType}');
                      setState(() {
                        _image = image.path;
                      });

                      APIs.updateProfilePicture(File (_image!) );

                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/document.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(mq.size.width * .3, mq.size.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      print('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      APIs.updateProfilePicture(File (_image!) );
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/document.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

