
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notepade/model/note_model.dart';

class NoteControllar extends GetxController {
  final Box box=Hive.box('notes');

  void creatNote(NoteModel note) {
    box.add(note);
    update();
  }

  void updateNote(NoteModel note, int index) {
box.putAt(index, note);
  }

  void deleteNote(int index) {
    box.deleteAt(index);

  }
}