import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:challengify_app/src/models/DataTransferObject/challenge_creation_dto.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreateChallengeScreen extends StatefulWidget {
  final VoidCallback onNavigate;
  CreateChallengeScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  _CreateChallengeScreenState createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {
  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _selectedPeriodicity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  // Optional field, so no validator needed
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Periodicity (days)'),
                  value: _selectedPeriodicity,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPeriodicity = newValue!;
                    });
                  },
                  items: List.generate(
                    7,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1} day${index == 0 ? '' : 's'}'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FullWidhtButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ChallengeCreationDto challengeCreationDto =
                          ChallengeCreationDto(
                        title: _titleController.text,
                        description: _descriptionController.text.isEmpty
                            ? null
                            : _descriptionController.text,
                        periodicity: _selectedPeriodicity * 24,
                      );

                      await _challengeInteractor
                          .createChallenge(challengeCreationDto);

                      widget.onNavigate();
                    }
                  },
                  text: "Create Challenge",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
