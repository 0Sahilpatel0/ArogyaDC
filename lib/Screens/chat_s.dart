

// import 'dart:html';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:docu/widgets/message_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../models/message.dart';


class ChatScreen extends StatefulWidget {

  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  List<Message> _list = [];

  final _textController = TextEditingController();

  bool _isUploading = false;





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),

        backgroundColor: Color.fromARGB(255, 234, 248, 255),



        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return SizedBox();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data!.docs;
                        
                        // print('Data: ${data![0].data()}');
                        _list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              
              
                      // _list.clear();
                      // _list.add(Message(toId: 'xyz' , msg: 'HIeeeee' , read:'' , type:Type.text , fromId: APIs.user.uid , sent:'12:00 AM'));
                      //
                      // _list.add(Message(toId: APIs.user.uid , msg: 'HI' , read:'' , type:Type.text , fromId: 'xyz', sent:'12:00 AM'));









                        if (_list.isNotEmpty)
                        {
                          return ListView.builder(
                            reverse: true,
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(message: _list[index]);
              
                            },
                          );
                        }else
                        {
              
                          return Center(child: Text('Say Hi' , style: TextStyle(fontSize: 20)));
              
                        }
                      default:
                        return Center(
                            child: Text('Unexpected ConnectionState: ${snapshot.connectionState}'));
                    }
                  },
                  stream: APIs.getAllMessages(widget.user)
              ),
            ),



            if(_isUploading)

                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(

                        padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 20),


                        child: CircularProgressIndicator(strokeWidth: 2,))),











            _chatInput(),












          ],
        ),
      ),
    );
  }





  Widget _appBar()
  {
    return InkWell(
      onTap: (){},
      child: Row(
      
        children: [
          IconButton(
      
      
      
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back , color: Colors.black,)),
      
      
      
          ClipRRect(
      
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
      
              width: mq.height * .05,
              height: mq.height * .05,
              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person)),
      
      
      
              // },
            ),
          ),
      
          SizedBox(width: 10),
      
          Column(
      
            mainAxisAlignment: MainAxisAlignment.center,
      
            crossAxisAlignment: CrossAxisAlignment.start,
      
      
            children: [
              Text(widget.user.name ,
                style: TextStyle(fontSize: 16 ,
                    color: Colors.black54 ,
                    fontWeight: FontWeight.w900
                ),) ,
      
              SizedBox(height: 1),
      
      
      
              Text('Last Seen Not Available' ,
                style: TextStyle(fontSize: 14 ,
                    color: Colors.black54 ,
                ),)
      
      
      
      
      
      
      
            ],)
      
      
      
      
        ],
      ),
    );
  }




  Widget _chatInput () {
    return Padding(
      padding:  EdgeInsets.symmetric(

          vertical: mq.height * .01 , horizontal: mq.width * .025),


      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Row(children: [
                IconButton(
                  onPressed: () {

                    // setState(() => _showEmoji =! _showEmoji);
                    // Navigator.pop(context);
                  },
                  icon: Icon(Icons.emoji_emotions , color: Colors.black,size: 26)),



                Expanded(child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Type Somthing....' ,
                      hintStyle: TextStyle(color: Colors.black54)  ,
                      border: InputBorder.none),
                )),



                IconButton(
                    onPressed: () async {

                        // final ImagePicker picker = ImagePicker();
                        // final List<XFile>? images = await picker.pickMultiImage(
                        //      );
                        //
                        // for (var i in images!)
                        //   {
                        //
                        //     await APIs.sendChatImage(widget.user,File (i.path) );
                        //
                        //
                        //   }





                      final ImagePicker picker = ImagePicker();
                      final List<XFile>? images = await picker.pickMultiImage();

                          for (var i in images!)
                            {

                              setState(() => _isUploading = true);

                              await APIs.sendChatImage(widget.user,File (i.path) );
                              setState(() => _isUploading = false);




                            }




                      // if (images != null) {
                      //   print('Image Path: ${images.path} -- MimeType: ${images.mimeType}');
                      //
                      //
                      //   await APIs.sendChatImage(widget.user,File (images.path) );
                      //
                      //   // Navigator.pop(context);
                      // }

                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.image , color: Colors.black,size: 26)
                ),


                IconButton(
                    onPressed: () async {


                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.camera );
                      if (image != null) {
                        print('Image Path: ${image.path} -- MimeType: ${image.mimeType}');

                        setState(() => _isUploading = true);

                        await APIs.sendChatImage(widget.user,File (image.path) );

                        setState(() => _isUploading = false);



                        // Navigator.pop(context);
                      }


                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.camera_alt_rounded , color: Colors.black, size: 26,)),


              ],
              ),
            ),
          ),

          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty)
                {
                  
                  APIs.sendMessage(widget.user, _textController.text , Type.text);
                  _textController.text = '';
                  
                }
            } ,
            padding: EdgeInsets.only(top: 10 , bottom: 10 , right: 5 , left: 10),
            shape: CircleBorder(),
            minWidth: 0,
            color: Colors.green,
            child: Icon
              (Icons.send ,
                color:  Colors.white ,
                size: 28)),
          SizedBox(width: mq.width * .02)
        ],
      ),
    );
  }






}
