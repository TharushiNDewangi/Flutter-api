import 'package:flutter/material.dart';
import '../HTTPHelper.dart';

class EditEmployee extends StatefulWidget {
  EditEmployee(this.emp, {Key? key}) : super(key: key);
  Map emp;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  initState() {
    super.initState();
    _controllerTitle.text = widget.emp['title'];
    _controllerBody.text = widget.emp['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
              ),
              TextFormField(
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };

                    bool status = await HTTPHelper()
                        .updateItem(dataToUpdate, widget.emp['id'].toString());

                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Employee updated')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to update the Employee')));
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
