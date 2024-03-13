import 'package:flutter/material.dart';
import 'list.dart';

class descrip extends StatelessWidget {
  final String title;
  final String description;

  descrip({Key? key, required this.title, required this.description}): super(key: key);

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
              SizedBox(
                width: 15,
              ),
            ],
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text('Description',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => list()),
                );
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
