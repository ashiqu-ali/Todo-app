import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopupContent extends StatefulWidget {
  @override
  State<PopupContent> createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  final CollectionReference data = FirebaseFirestore.instance.collection('Datas');

  final TextEditingController _title = TextEditingController();
  final TextEditingController _subtitle = TextEditingController();

  void addData() {
    final dat = {
      'Title': _title.text,
      'Subtitle': _subtitle.text,
    };

    data.add(dat);
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
                      addData();
                      Navigator.of(context).pop();
                    },
                    child: const Text('ADD'),
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
