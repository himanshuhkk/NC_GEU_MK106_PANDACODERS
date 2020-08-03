import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int id;
  final String name;
  final dynamic icon;
  Category(this.id, this.name, {this.icon});

}

final List<Category> categories = [

  Category(17,"Science & Nature", icon: FontAwesomeIcons.microscope),
  Category(18,"Computer", icon: FontAwesomeIcons.laptopCode),
  Category(19,"Maths", icon: FontAwesomeIcons.sortNumericDown),
  Category(20,"Mythology"),
  Category(21,"Sports", icon: FontAwesomeIcons.footballBall),
  Category(22,"Air craft", icon: FontAwesomeIcons.mountain),
  Category(23,"Senior Sec", icon: FontAwesomeIcons.monument),
  Category(24,"Politics"),
  Category(25,"Art", icon: FontAwesomeIcons.paintBrush),
  Category(26,"SoftWare"),
  Category(27,"CDS", icon: FontAwesomeIcons.dog),
  Category(28,"Civil Services", icon: FontAwesomeIcons.carAlt),
  Category(29,"Comics"),
  Category(30,"Gadgets", icon: FontAwesomeIcons.mobileAlt),
  Category(31,"GATE"),
  Category(32,"B.Tech"),
  Category(9,"General Knowledge", icon: FontAwesomeIcons.globeAsia),
  Category(10,"Finance", icon: FontAwesomeIcons.bookOpen),
  Category(11,"Film", icon: FontAwesomeIcons.video),
  Category(12,"Music", icon: FontAwesomeIcons.music),
  Category(13,"Banking", icon: FontAwesomeIcons.theaterMasks),
  Category(14,"Television", icon: FontAwesomeIcons.tv),
  Category(15,"Video Games", icon: FontAwesomeIcons.gamepad),
  Category(16,"Board Games", icon: FontAwesomeIcons.chessBoard),
];