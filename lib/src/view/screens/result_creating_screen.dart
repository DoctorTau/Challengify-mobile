import 'package:challengify_app/src/models/DataTransferObject/result_create_dto.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreateResultScreen extends StatefulWidget {
  final int challengeId;

  const CreateResultScreen({Key? key, required this.challengeId})
      : super(key: key);

  @override
  _CreateResultScreenState createState() => _CreateResultScreenState();
}

class _CreateResultScreenState extends State<CreateResultScreen> {
  final ChallengeInteractor challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              FullWidhtButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ResultCreateRequestDto resultCreateRequestDto =
                        ResultCreateRequestDto(
                      name: _nameController.text,
                      description: _descriptionController.text,
                    );

                    // print(resultCreateRequestDto.toJson());
                    await challengeInteractor.addResult(
                        widget.challengeId, resultCreateRequestDto);
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
