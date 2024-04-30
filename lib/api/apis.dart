//
//
//
// import 'dart:html';
//
// import 'dart:io';
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:docu/models/chat_user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class APIs{
//
//
//
//
//
//   static late ChatUser me;
//
//   static FirebaseAuth auth = FirebaseAuth.instance;
//
//
//   static FirebaseStorage storage = FirebaseStorage.instance;
//
//
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//
//
//
//   static User get user => auth.currentUser!;
//
//
//
//   static Future <bool> userExists () async{
//     return(await firestore
//
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .get()).exists;
//   }
//
//
//
//
//   static Future <void> getSelfInfo () async{
//     await firestore
//
//         .collection('users')
//         .doc(user.uid)
//         .get()
//         .then((user) {
//
//           if(user.exists)
//             {
//
//               me = ChatUser.fromJson(user.data()!);
//
//             }else
//               {
//
//                  createUser().then((value) => getSelfInfo());
//
//               }
//
//     });
//   }
//
//
//
//   static Future <void> createUser () async{
//
//     final time = DateTime.now().microsecondsSinceEpoch.toString();
//
//     final chatUser = ChatUser(
//       id: user.uid,
//       name: user.displayName.toString(),
//       email: user.email.toString(),
//       about: "Hi I am using this app",
//       image: user.photoURL.toString(),
//       createdAt: time,
//       isOnline: false,
//       lastActive: time,
//       pushToken: ''
//
//     );
//
//
//
//     return await firestore.collection('users').doc(user.uid).set(chatUser.toJson()) ;
//   }
//
//
//
//   static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers()
//   {
//     return firestore
//         .collection('users')
//         .where('id' , isNotEqualTo: user.uid)
//         .snapshots();
//   }
//
//
//
//
//   static Future <void> updateUserInfo () async{
//     await firestore
//
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .update({
//
//             'name' : me.name ,
//             'about' : me.about,
//
//         });
//   }
//
//
//   static Future<void> updateProfilePicture(File file) async{
//
//     final ext = file.path.split('.'),last;
//     print ('Extension : $ext');
//     final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
//     await ref
//
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0){
//           print ('Data Transfer : ${p0.bytesTransferred / 1000} kb');
//     }
//     );
//
//   }
//   }





import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docu/models/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/message.dart';

class APIs {
  static late ChatUser me;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;


  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(auth.currentUser!.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hi I am using this app",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
    );

    await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection('users').where('id', isNotEqualTo: user.uid).snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    print('Extension : $ext');
    final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('Data Transfer : ${p0.bytesTransferred / 1000} kb');
    });

    me.image = await ref.getDownloadURL();

    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'image': me.image,
    });


  }



  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';









  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent' , descending: true)
        .snapshots();
  }




  static Future<void> sendMessage (ChatUser chatUser , String msg , Type type) async
  {

    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final Message message = Message(toId: chatUser.id, msg: msg, read: '', type: type, fromId: user.uid, sent: time);


    final ref = firestore.collection('chats/${getConversationID(chatUser.id)}/messages/');
    ref.doc(time).set(message.toJson());
  }


  static Future<void> updateMessageReadStatus(Message message) async{

    firestore.collection('chats/${getConversationID(message.fromId)}/messages/').doc(message.sent).update({'read' : DateTime.now().microsecondsSinceEpoch.toString()});




  }



  static Stream<QuerySnapshot> getLastMessaeg (ChatUser user)
  {

    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)

        .limit(1)
        .snapshots();

  }



  static Future <void> sendChatImage (ChatUser chatUser , File file)
  async {



    final ext = file.path.split('.').last;

    final ref = storage.ref().child('images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('Data Transfer : ${p0.bytesTransferred / 1000} kb');
    });

    final imageUrl = await ref.getDownloadURL();

    await APIs.sendMessage(chatUser, imageUrl, Type.image);



  }


}
