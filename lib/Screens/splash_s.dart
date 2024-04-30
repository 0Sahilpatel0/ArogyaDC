import 'package:docu/Screens/Auth/logins.dart';
import 'package:docu/Screens/home_s.dart';
import 'package:docu/api/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenSState();
}

class _SplashScreenSState extends State<SplashScreen> {




  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 3) ,()  {




      if(APIs.auth.currentUser != null)
        {

          print('\nUser: ${APIs.auth.currentUser != null}');


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeS()));


        }else{

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginS()));


      }


    } );
  }






  @override
  Widget build(BuildContext context) {


    mq = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(


        automaticallyImplyLeading: false,


        iconTheme: IconThemeData(color: Colors.white),

        centerTitle: true,
        elevation: 1,
        title: Text (" Welcome ot ArogyaDC"  ,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 20
            )),
        backgroundColor: Colors.green,
      ),


      body: Stack(children: [
        Positioned(
          top: mq.height * .15,
          right: mq.width * .25  ,
          width: mq.width * .5,
          child: Image.asset('images/document.png'),

        ),
        Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.width * .12,
          child: Text("Develop by Sahil Patel" ,

            textAlign: TextAlign.center,
            style: TextStyle (


              fontSize: 16,

              color: Colors.black,

              letterSpacing: .5,






            ),

          ) ,

        )
      ],),





    );
  }
}
