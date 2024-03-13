import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'list.dart';
import 'reg.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => startState();
}


class startState extends State<start> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Future.delayed(Duration(seconds: 5)).then((value) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => list()),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 5)).then((value) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => reg()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/home.jpg"),
                fit: BoxFit.fill),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 170,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Image.asset(
                              'images/image.jpg',
                              width: 170,
                              height: 170,
                            ),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Todo List',
                              style: TextStyle(
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,color: Colors.white)),
                        ],
                      ),
                      Text(
                          " Let's Go ",textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 50,
                      ),
                      SpinKitWaveSpinner(
                        color: Colors.white,
                        size: 50,
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}