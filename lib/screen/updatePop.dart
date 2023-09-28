import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePopup extends StatefulWidget {
  final String title;
  final String sub;
  final String id;

  const UpdatePopup({Key? key, required this.title, required this.sub, required this.id})
      : super(key: key);

  @override
  State<UpdatePopup> createState() => _UpdatePopupState();
}

class _UpdatePopupState extends State<UpdatePopup> {
  final CollectionReference data = FirebaseFirestore.instance.collection('Datas');

  late TextEditingController _title;
  late TextEditingController _subtitle;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.title);
    _subtitle = TextEditingController(text: widget.sub);
  }

  void updateData(String id) async {
    final dat = {
      'Title': _title.text,
      'Subtitle': _subtitle.text,
    };
    await data.doc(id).update(dat);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _title,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextField(
                    controller: _subtitle,
                    decoration: InputDecoration(labelText: 'Subtitle'),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      updateData(widget.id);
                      Navigator.of(context).pop();
                    },
                    child: const Text('UPDATE'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}