
import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  String? name;
  List<String>? images;
  String? coverImage;
  bool check  = false;

  Breed({this.name, this.images, this.check = false, this.coverImage });

  Breed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if(json.containsKey("images")) {
      images = json['images'].cast<String>();
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    if(coverImage!=null) data['coverImage'] = coverImage;
    if(images != null) data['images'] = images!.take(5).toList();
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [name];





}