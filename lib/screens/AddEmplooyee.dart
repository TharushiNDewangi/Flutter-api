import 'package:appapi/HTTPHelper.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddPostState();
}

class _AddPostState extends State<AddEmployee> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Add a name'),
                controller: _controllerTitle,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Add a body'),
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };

                    bool status = await HTTPHelper().addItem(dataToUpdate);

                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Employee added')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to add the Employee')));
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
