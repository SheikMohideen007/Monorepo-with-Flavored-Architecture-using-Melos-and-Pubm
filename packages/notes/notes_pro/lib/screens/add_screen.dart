import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  final bool isPremium;
  final String type;
  final Function(String text, String? imagePath) onSave;

  const AddScreen({
    required this.isPremium,
    required this.type,
    required this.onSave,
  });

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _textController = TextEditingController();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add ${widget.type}')),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Text'),
          ),

          imagePickerButton(context, (img) => setState(() => _image = img)),
          if (_image != null) Image.file(File(_image!.path), height: 100),
          ElevatedButton(
            onPressed: () {
              if (widget.isPremium && _image == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add image for premium')),
                );
                return;
              }
              widget.onSave(_textController.text, _image?.path);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

Future<XFile?> pickImage(ImageSource source) async {
  return ImagePicker().pickImage(source: source);
}

Widget imagePickerButton(BuildContext context, Function(XFile?) onPicked) {
  return Row(
    children: [
      IconButton(
        icon: Icon(Icons.camera),
        onPressed: () async => onPicked(await pickImage(ImageSource.camera)),
      ),
      IconButton(
        icon: Icon(Icons.photo),
        onPressed: () async => onPicked(await pickImage(ImageSource.gallery)),
      ),
    ],
  );
}
