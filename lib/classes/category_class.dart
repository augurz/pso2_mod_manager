import 'package:pso2_mod_manager/classes/item_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_class.g.dart';

@JsonSerializable()
class Category {
  Category(this.name, this.location, this.visible, this.items);
  String name;
  Uri location;
  bool visible;
  List<Item> items;
  

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}