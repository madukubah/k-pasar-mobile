class Adverticement {
  final int id;
  final String name;
  final String description;
  final String images;

  Adverticement( { this.id, this.name, this.description, this.images });
 

  Adverticement.fromMap(Map<String, dynamic> map)
      : id = int.parse(  map['id'] ),
        name = map['name'],
        images = map['images'],
        description = map['description'];
}
