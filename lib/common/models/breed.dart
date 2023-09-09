
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Breed extends Equatable {
  String? name;
  List<String>? images;
  List<Uint8List> imageBytes =[];
  String? coverImage;
  bool check  = false;

  Breed({this.name, this.images, this.check = false, this.coverImage });

  Breed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if(json.containsKey("images")) {
      images = json['images'].cast<String>();
    }

    if(json.containsKey("imageBytes")) {
      imageBytes = (json['imageBytes'] as List)
          .map((e) => Uint8List.fromList( e.cast<int>() )).toList();
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    if(coverImage!=null) data['coverImage'] = coverImage;
    if(imageBytes.isNotEmpty) data['imageBytes'] = imageBytes;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [name];





}