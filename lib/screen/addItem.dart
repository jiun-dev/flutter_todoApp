import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할 일 추가'),
      ),
      body: TextField(
        autofocus: true,
        onSubmitted: (val) {
          Navigator.of(context).pop({'item': val});
        },
      ),
    );
  }
}
