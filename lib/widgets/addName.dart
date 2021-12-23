import 'package:flutter/material.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final _keyForm = GlobalKey<FormState>();
  String _tagName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Please enter a tag name',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: "Tag Name",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (deger) {
                      if (deger!.length < 1) {
                        return "please enter at least one number";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (deger) {
                      _tagName = deger!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        bool _validate = _keyForm.currentState!.validate();
                        if (_validate) {
                          _keyForm.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('box named $_tagName  is created')));

                          Navigator.pop(context, _tagName);
                        }
                      },
                      child: const Text("Confirm"))
                ],
              ),
            ),
          )),
    );
  }
}
