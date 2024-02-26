import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onImageTaken,
  });

  final void Function(File takenImage) onImageTaken;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
    );

    if (takenImage != null) {
      setState(() => _takenImage = File(takenImage.path));
      widget.onImageTaken(_takenImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: _takenImage == null
          ? TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
              onPressed: _takePicture,
            )
          : GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                _takenImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }
}
