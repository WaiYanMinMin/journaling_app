

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

@Entity(tableName: 'profile')
class Profile {
  @PrimaryKey(autoGenerate: false)
  int? id;
  @ColumnInfo(name: 'profiletitle')
  String firstName;
  String lastName;
  String city;
  String country;
  String bgImage;
  String profileImage;

  Profile(this.firstName, this.lastName, this.city, this.country, this.bgImage,
      this.profileImage,
      this.id);
}
