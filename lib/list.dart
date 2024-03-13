import 'package:flutter/material.dart';
import 'package:todo/description.dart';
import 'log.dart';
import 'report.dart';
import 'task.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';


class list extends StatefulWidget {
  const list({super.key});
  @override
  State<list> createState() => listState();
}

class listState extends State<list> {
  late String uid = '';
  @override
  void initState() {
    super.initState();
    getUid();
  }

  Future<void> getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    } else {
      print('Problem Occurs');
    }
  }

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
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset(
                  'images/image.jpg',
                  width: 35,
                  height: 35,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(top: 2, right: 2),
                        child: Align(
                          alignment: Alignment.center,
                          child: AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Share.share(
                                        'com.example.todo');
                                  },
                                  leading: Icon(Icons.share,
                                      color: Colors.teal),
                                  title: Text('Share',
                                      style: TextStyle(
                                          color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => report(),
                                      ),
                                    );
                                  },
                                  leading: const Icon(Icons.report,
                                      color: Colors.teal),
                                  title: Text('Report',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                ListTile(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut().then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => log(),
                                        ),
                                      );
                                    });
                                  },
                                  leading: const Icon(Icons.logout,
                                      color: Colors.teal),
                                  title: Text('LogOut',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text('Todo List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, color: Colors.teal),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .doc(uid)
                  .collection('mytasks')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No tasks available',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  );
                } else {
                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var time =
                      (docs[index]['timestamp'] as Timestamp).toDate();

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => descrip(
                                title: docs[index]['title'],
                                description: docs[index]['description'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      docs[index]['title'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      DateFormat.yMd().add_jm().format(time),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(docs[index].id)
                                      .delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_task, color: Colors.white),
              backgroundColor: Colors.teal,
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => tasks()));
              }),
        ),
      ),
    );
  }
}
