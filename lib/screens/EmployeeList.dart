import 'package:flutter/material.dart';

import 'package:appapi/HTTPHelper.dart';
import 'package:appapi/screens/AddEmplooyee.dart';
import 'package:appapi/screens/EmpDetails.dart';

import '../HTTPHelper.dart';

class EmployeeList extends StatelessWidget {
  EmployeeList({Key? key}) : super(key: key);

  Future<List<Map>> _futureEmp = HTTPHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Employees'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddEmployee()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futureEmp,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          //Has data arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map thisItem = posts[index];
                  return ListTile(
                    title: Text('${thisItem['title']}'),
                    subtitle: Text('${thisItem['body']}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EmployeeDetails(thisItem['id'].toString())));
                    },
                  );
                });
          }

          //Display a loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
