import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sqlflite_1/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                child: Text("Insert data"),
                onPressed: () async {
                  int response = await sqlDb.insertData(
                      "INSERT INTO 'notes' ('note') VALUES ('note two')");
                  print(response);
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
            Center(
              child: MaterialButton(
                child: Text("Update data"),
                onPressed: () async {
                  int response = await sqlDb.updateData(
                      "UPDATE 'notes' SET 'note' = 'note Six' WHERE (id = 6)");
                  print('$response');
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: MaterialButton(
                child: Text("Read data"),
                onPressed: () async {
                  List<Map> response =
                      await sqlDb.readData("SELECT * FROM 'notes'");
                  print('$response');
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
            Center(
              child: MaterialButton(
                child: Text("Delete data"),
                onPressed: () async {
                  int response = await sqlDb
                      .deleteData("DELETE FROM 'notes'  WHERE ( id = 4)");
                  print('$response');
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
