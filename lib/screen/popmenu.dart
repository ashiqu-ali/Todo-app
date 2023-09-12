import 'package:flutter/material.dart';

class PopupContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Subtitle'),
          ),
          SizedBox(height: 25),
          ElevatedButton(
              onPressed: (){},
              child: Text('ADD')
          )
        ],
      ),
    );
  }
}
