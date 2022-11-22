import 'package:appapi/screens/UpdateEmployee.dart';
import 'package:flutter/material.dart';
import '../HTTPHelper.dart';

class EmployeeDetails extends StatelessWidget {
  EmployeeDetails(this.itemId, {Key? key}) : super(key: key) {
    _futureEmp = HTTPHelper().getItem(itemId);
  }

  String itemId;
  late Future<Map> _futureEmp;
  late Map post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EditEmployee(post)));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                //Delete
                bool deleted = await HTTPHelper().deleteItem(itemId);

                if (deleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Employee deleted')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete')));
                }
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: FutureBuilder<Map>(
        future: _futureEmp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            post = snapshot.data!;

            return Column(
              children: [
                Text(
                  '${post['title']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${post['body']}'),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
