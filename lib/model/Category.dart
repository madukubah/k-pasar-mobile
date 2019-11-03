class Category {
  final int id;
  final String name;
  final String routeName;
  final String image;

  Category( { this.id, this.name, this.routeName, this.image });
 

  Category.fromMap(Map<String, dynamic> map)
      : id = int.parse(  map['id'] ),
        name = map['name'],
        image = map['image'],
        routeName = map['routeName'] == null ? "": map['routeName'] ;
}
