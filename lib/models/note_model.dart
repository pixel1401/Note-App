

// class NoteModel {
//   int? id;
//   String title, body;
//   DateTime creation_date;

//   NoteModel(
//       { this.id,
//       required this.title,
//       required this.body,
//       required this.creation_date});

//   Map<String, dynamic> toMap() {
//     return ({
//       "id":id,
//       "title":title,
//       "body":body,
//       "creation_date": creation_date.toString()
//     });
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';


@freezed
class NoteModel with _$NoteModel {

  const factory NoteModel({
    int? id,
    required String title,
    required String body,
    required DateTime creation_date
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);

}
