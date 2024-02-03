import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepade/controller/note_controllar.dart';
import 'package:notepade/model/note_model.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  Color greencolor = Colors.green;

  TextEditingController idClt = TextEditingController();
  TextEditingController nameClt = TextEditingController();
  TextEditingController deptClt = TextEditingController();
  NoteControllar noteControllar = Get.put(NoteControllar());
  final Box box=Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NotePade"),
        backgroundColor: greencolor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogue(context);
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<NoteControllar>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ValueListenableBuilder(
            valueListenable:box.listenable() ,
            builder: (context, box,child) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: box.keys.length,
                  itemBuilder: (context, index) {
                    NoteModel note=box.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Text(note.id),
                        title: Text(
                          note.name,
                        ),
                        subtitle: Text(
                         note.department,
                        ),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _showUpdateDialogue(context, index);
                                },
                                child: Icon(Icons.edit),
                              ),
                              InkWell(
                                onTap: () {
                                  noteControllar.deleteNote(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.deepOrange,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          ),
        );
      }),
    );
  }

  _showUpdateDialogue(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: idClt,
                      decoration: InputDecoration(hintText: 'Student id'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: nameClt,
                      decoration: InputDecoration(hintText: 'Student name'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: deptClt,
                      decoration:
                      InputDecoration(hintText: 'Student department'),
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cencle',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      noteControllar.updateNote(
                          NoteModel(idClt.text, nameClt.text, deptClt.text),
                          index);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                    ElevatedButton.styleFrom(backgroundColor: greencolor),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: idClt,
                      decoration: InputDecoration(hintText: 'Student id'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: nameClt,
                      decoration: InputDecoration(hintText: 'Student name'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: deptClt,
                      decoration:
                      InputDecoration(hintText: 'Student department'),
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cencel',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      noteControllar.creatNote(
                          NoteModel(idClt.text, nameClt.text, deptClt.text));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                    ElevatedButton.styleFrom(backgroundColor: greencolor),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
