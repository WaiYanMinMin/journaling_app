import 'package:floor/floor.dart';

@Entity(tableName: 'note')
class Note {
  @PrimaryKey(autoGenerate: true)
  int? id;
  @ColumnInfo(name: 'title')
  String title;
  String description;
  String photo;
  int emoji;
  int weather;
  String dueDate;

  Note(
      {this.id,
      required this.title,
      required this.description,
      required this.photo,
      required this.emoji,
      required this.weather,
      required this.dueDate});
}
