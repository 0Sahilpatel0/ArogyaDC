import 'package:cached_network_image/cached_network_image.dart';
import 'package:docu/api/apis.dart';
import 'package:docu/helper/my_date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
      ? _greenMessage()
      : _blueMessage();
    ;
  }

  Widget _blueMessage()
  {

    if(widget.message.read.isEmpty)
      {
        APIs.updateMessageReadStatus(widget.message);
      }



    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image ? mq.width * .03 : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04 , vertical: mq.height * .01 ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30) ,
                    topRight: Radius.circular(30) ,
                    bottomRight: Radius.circular(30),) ),
          
            child:

                widget.message.type == Type.text ?
            Text(
                widget.message.msg ,
                style: TextStyle(fontSize: 15 , color: Colors.black )
            ) :

                ClipRRect(

                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(


                    imageUrl: widget.message.msg,
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) =>

                    const Icon(Icons.image),



                    // },
                  ),
                ),

          ),
        ),
        
        
        Padding(
          padding:  EdgeInsets.only(right: mq.width * .04),
          child: Text(MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
            style: TextStyle(fontSize: 12 , color: Colors.black54),
          ),
        ),


      ],
    );
  }


  Widget _greenMessage()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [



        Row(
          children: [

            SizedBox( width: mq.width * .04,),

            if (widget.message.read.isNotEmpty)


            Icon(Icons.done_all_rounded , color: Colors.blue , size: 20,),


            SizedBox( width: 2,),





            Text( MyDateUtil.getFormattedTime(context: context, time: widget.message.sent)  ,
              style: TextStyle(fontSize: 12 , color: Colors.black54),
            ),
          ],
        ),

        Flexible(
          child: Container(
            padding: EdgeInsets.all( widget.message.type == Type.image ? mq.width * .03 : mq.width * .04  ),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04 , vertical: mq.height * .01 ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 218 ,255, 176),
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30) ,
                  topRight: Radius.circular(30) ,
                  bottomLeft: Radius.circular(30),) ),

            child: widget.message.type == Type.text ?
            Text(
                widget.message.msg ,
                style: TextStyle(fontSize: 15 , color: Colors.black )
            ) :

            ClipRRect(

              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(


                imageUrl: widget.message.msg,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) =>

                const Icon(Icons.image),



                // },
              ),
            ),

          ),
        ),


      ],
    );;
  }
}
