import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sqlflite_1/editnotes.dart';
import 'package:flutter_sqlflite_1/sqldb.dart';

class SqlPage extends StatefulWidget {
  const SqlPage({Key? key}) : super(key: key);

  @override
  State<SqlPage> createState() => _SqlPageState();
}

class _SqlPageState extends State<SqlPage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes ");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('addnotes');
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView(children: [
                /*  MaterialButton(
            onPressed: () async {
              await sqlDb.mydeleteDatabase();
            },
            child: Text("delete mydatabase"),
          ), */
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                          title: Text("${notes[i]['note']}"),
                          subtitle: Text("${notes[i]['title']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  //delted freom database
                                  int response = await sqlDb.deleteData(
                                      "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                                  if (response > 0) {
                                    //delete from UI
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    print("================");
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditNotes(
                                            color: notes[i]['color'],
                                            note: notes[i]['note'],
                                            title: notes[i]['title'],
                                            id: notes[i]['id'],
                                          )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                  itemCount: notes.length,
                ),
              ]),
            ),
    );
  }
}


/* 
FutureBuilder(
            future: readData(),
            builder:
                ((BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text("${snapshot.data![i]['note']}"),
                        subtitle: Text("${snapshot.data![i]['title']}"),
                        trailing: IconButton(
                            onPressed: () async {
                              int response = await sqlDb.deleteData(
                                  "DELETE FROM notes WHERE id = ${snapshot.data![i]['id']}");
                              if (response > 0) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) => SqlPage())));
                              }
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Colors.red,
                            )),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
          ), */