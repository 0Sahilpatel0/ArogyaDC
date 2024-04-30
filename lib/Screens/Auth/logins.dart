import 'dart:io';
import 'dart:math';

import 'package:docu/Screens/home_s.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/apis.dart';
import '../../helper/dialoge.dart';
import '../../main.dart';



class LoginS extends StatefulWidget {
  const LoginS({super.key});

  @override
  State<LoginS> createState() => _LoginSState();
}

class _LoginSState extends State<LoginS> {


  bool _isAnimate = false;


  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(microseconds: 500) ,()  {
      setState(() {
        _isAnimate = true;
      });
    } );
  }



  _handleGoogleBtnClick(){

    Dialogs.showProgressBar(context);


    _signInWithGoogle().then((user) async {

      Navigator.pop(context);

      if (user != null)
        {


          // log ('User: ${user.user}');
          //
          // log ('UserAdditionalInfo: ${user.additionalUserInfo}')


          print('User: ${user.user}');
          print('UserAdditionalInfo: ${user.additionalUserInfo}');

          if ((await APIs.userExists()))
            {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeS() ));


            }else{
            await APIs.createUser().then((value)
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeS() ));

                });
          }




        }

    });

  }


  Future<UserCredential?> _signInWithGoogle() async {

    try{

      await InternetAddress.lookup('google.com');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);




    }catch(e) {

      // log('_signInWithGoogle: $e');

      print('_signInWithGoogle: $e');

      Dialogs.showSnackbar (context , 'Something Went Wrong (Check Internet!)');

      return null;

    }

  }


  // sign out function
  // _signOut() async{
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }






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
        AnimatedPositioned(
          top: mq.height * .15,
          right: _isAnimate? mq.width * .25 : -mq.width * .5 ,
          width: mq.width * .5,
          duration: Duration(seconds: 5),
          child: Image.asset('images/document.png'),

        ),
        Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.width * .12,
          child: ElevatedButton.icon(

            style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: StadiumBorder() , elevation: 7),


              onPressed: (){
              _handleGoogleBtnClick();
              },

              icon: Image.asset('images/document.png' , height: mq.height * .04), label: RichText(text: TextSpan(

            style: TextStyle(color: Colors.black , fontSize: 19),


              children: [

                TextSpan(text: 'Login With '),
                TextSpan(text: 'Google'  , style: TextStyle(fontWeight: FontWeight.w900)),


          ]),)),

        )
      ],),





    );
  }
}
