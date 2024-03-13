import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'list.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);
  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  TextEditingController reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/image1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text('Report Problems',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white)),
            leading: IconButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => list()));
              },
              icon:Icon(Icons.arrow_back_ios,color: Colors.white),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 0, right: 15),
                child: Image.asset(
                  'images/image.jpg',
                  width: 35,
                  height: 35,
                ),
              ),
            ],

          ),

          body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Column(
                      children: [
                        SizedBox(
                            height: 40
                        ),
                        Text(
                          'Please let us know What problems are you facing?',
                          style: TextStyle(fontSize: 17,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: reportController,
                          style: TextStyle(fontSize: 15),
                          maxLines: 100,
                          minLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: 'Write your problems here',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var report = reportController.text.trim();
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc()
                                .set({
                              "problems": report,
                            }).then((_) {
                              print("Report stored in Firestore successfully");
                              // Navigate to the next screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => list(),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          child: (Text("Submit",
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                        ),
                      ]))),
        ),
      ),
    );
  }
}
