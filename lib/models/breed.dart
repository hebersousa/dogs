
import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  String? name;
  List<String>? images;
  bool check  = false;

  Breed({this.name, this.images, this.check = false });

  Breed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if(json.containsKey("images"))
      images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if(images != null) data['images'] = this.images;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [name,check];





}