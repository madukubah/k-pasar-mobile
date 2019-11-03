class Gallery {
  final int id;
  final String name;
  final String description;

  final String images;

  Gallery({ this.id, this.name, this.description, this.images });
 

  Gallery.fromMap(Map<String, dynamic> map)
      : id = int.parse(  map['id'] ),
        name = map['name'],
        images = map['images'],
        description = map['description'];
}
