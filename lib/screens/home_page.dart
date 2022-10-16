import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/db/database_provider.dart';
import 'package:todo_app/models/note_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<NoteModel>>? getNotes() async {
    List<NoteModel>? notes = await DatabaseProvider.db.getNotes();
    return notes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.data == Null || snapshot.data!.isEmpty) {
                return Text('You do not have any notes');
              } else {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: ((context, index) {
                        NoteModel currentNote = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/add',
                                  arguments: NoteModel(
                                      id: currentNote.id,
                                      title: currentNote.title,
                                      body: currentNote.body,
                                      creation_date:
                                          currentNote.creation_date));
                            },
                            title: Text(currentNote.title),
                            subtitle: Text(currentNote.body),
                          ),
                        );
                      })),
                );
              }
            default:
              return Text('WHAT');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
