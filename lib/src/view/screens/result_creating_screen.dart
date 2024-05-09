import 'dart:io';

import 'package:challengify_app/src/models/DataTransferObject/result_create_dto.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:challengify_app/src/web_interactors/file_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class CreateResultScreen extends StatefulWidget {
  final int challengeId;

  const CreateResultScreen({super.key, required this.challengeId});

  @override
  _CreateResultScreenState createState() => _CreateResultScreenState();
}

class _CreateResultScreenState extends State<CreateResultScreen> {
  final ChallengeInteractor challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final _fileInteractor = FileInteractor(baseUrl: dotenv.env['BASEURL']!);

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      await _fileInteractor.uploadFile(_image!);
    }
  }

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FullWidhtButton(
                onPressed: _pickImage,
                text: 'Pick Image from Gallery',
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Expanded(child: Image.file(_image!))
                  : const Text('No image selected'),
              const SizedBox(height: 20),
              FullWidhtButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ResultCreateRequestDto resultCreateRequestDto =
                        ResultCreateRequestDto(
                      name: _nameController.text,
                      description: _descriptionController.text,
                    );

                    if (_image == null) {
                      await challengeInteractor.addResult(
                          widget.challengeId, resultCreateRequestDto);
                    } else {
                      await challengeInteractor.addResultWithMedia(
                          widget.challengeId, resultCreateRequestDto, _image!);
                    }
                    Navigator.pop(context);
                  }
                },
                text: "Create Result",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
