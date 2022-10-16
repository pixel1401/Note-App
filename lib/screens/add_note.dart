import 'package:flutter/material.dart';
import 'package:todo_app/db/database_provider.dart';
import 'package:todo_app/models/note_model.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title, body;
  late DateTime date;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) async {
    await DatabaseProvider.db.addNewNote(note);
  }

  @override
  Widget build(BuildContext context) {
    var props = ModalRoute.of(context)!.settings.arguments;

    final NoteModel? changeNote = props != null ? props as NoteModel : null;

    if (changeNote != null) {
      titleController.text = changeNote.title;
      bodyController.text = changeNote.body;
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Note'),
        actions: [
          if (changeNote != null)
            IconButton(
                onPressed: () {
                  DatabaseProvider.db.deleteNote(changeNote.id!);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Note Title"),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextFormField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Your note'),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          title = titleController.text;
          body = bodyController.text;
          date = DateTime.now();

          NoteModel note = NoteModel(
              title: title,
              body: body,
              creation_date: date,
              id: changeNote != null ? changeNote.id : null);
          if (changeNote != null) {
            DatabaseProvider.db.changeNote(note);
          } else {
            addNote(note);
          }
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        icon: Icon(Icons.save),
        label: Text(changeNote != null ? 'Change' : 'Save Note'),
      ),
    );
  }
}
