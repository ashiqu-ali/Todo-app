import 'package:flutter/material.dart';
import 'package:todoapp/screen/popmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.logout)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Title here!',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Subtitle',
                              style: TextStyle(
                                  fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 115),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.edit)
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.delete)
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return PopupContent(); // Use the widget you created earlier
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
