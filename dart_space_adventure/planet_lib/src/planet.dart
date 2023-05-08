class Planet {

  final String name;
  final String description;

  Planet({this.name, this.description});

  Planet.nullPlanet() : name = '', description = '';

  /// Transform [[ {"name": "Foo", "description": "Bar"},... ]] into a [List<Planet>].
  static List<Planet> fromMaps(Iterable planetMaps) {
    return List<Planet>.from( 
      planetMaps.map(
        (item) => Planet(name: item['name'], description: item['description'])
      )
    );
  }

}