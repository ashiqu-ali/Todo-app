import 'package:flutter/material.dart';
import 'package:todoapp/screen/popmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/screen/updatePop.dart';

class Todo extends StatefulWidget {

  Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final CollectionReference data = FirebaseFirestore.instance.collection('Datas');
  TextEditingController _title = TextEditingController();
  TextEditingController _subtitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: const [
          Icon(Icons.logout)
        ],
      ),
      body: StreamBuilder(
        stream: data.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print('Error${snapshot.error}');
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot dataSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                                      dataSnap['Title'],
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      dataSnap['Subtitle'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return UpdatePopup(
                                              title: dataSnap['Title'],
                                              sub: dataSnap['Subtitle'],
                                              id: dataSnap.id,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDeleteConfirmationDialog(dataSnap.id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return PopupContent(); // Use the widget you created earlier
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                deleteData(id);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void deleteData(String id) async{
    await data.doc(id).delete();
  }
}