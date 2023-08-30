
class Breed {
  String? name;
  List<String>? images;

  Breed({this.name, this.images});

  Breed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if(json.containsKey("images"))
      images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['images'] = this.images;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }


}