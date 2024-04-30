
import 'package:cached_network_image/cached_network_image.dart';
import 'package:docu/api/apis.dart';
import 'package:docu/helper/my_date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/chat_s.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';

import 'package:cloud_firestore/cloud_firestore.dart';




class ChatUserCard extends StatefulWidget {


  final ChatUser user;

  const ChatUserCard({super.key, required this.user});


  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .03 , vertical: 6),
      color: Colors.green.shade50,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {

          Navigator.push(context , MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));



        },
        child: StreamBuilder(
            builder: (context, snapshot)
          {

            final data = snapshot.data?.docs;

            final list = data
                ?.map((e) => Message.fromJson(e.data() as Map<String, dynamic>))
                .toList() ?? [];






            if (list.isNotEmpty)
              {
                _message= list[0];
              }


            return ListTile(


              // leading: CircleAvatar(child: Icon(CupertinoIcons.person),),
              leading: ClipRRect(

                borderRadius: BorderRadius.circular(mq.height * .3),
                child: CachedNetworkImage(

                  width: mq.height * .065,
                  height: mq.height * .065,
                  imageUrl: widget.user.image,
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),




                ),
              ),


              // title: Text(widget.user.name),
              //   subtitle: Text(widget.user.about , maxLines: 1,),
              //   trailing: Text('12:00 PM' , style: TextStyle(color: Colors.black54),),


              title: Text( widget.user.name),
              subtitle: Text(
                _message != null ?
                    _message!.type == Type.image ?

                        'image'
                        :
                _message!.msg

                    : widget.user.about , maxLines: 1,),


              trailing:  _message == null

              ? null
              : _message!.read.isEmpty && _message?.fromId != APIs.user.uid ?

              Container

                (
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(10)
                ),
              ) : Text(

                 MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
              style: TextStyle(color: Colors.black54),




              )







            );



          },stream: APIs.getLastMessaeg(widget.user),

        )




        )

    );
  }
}








