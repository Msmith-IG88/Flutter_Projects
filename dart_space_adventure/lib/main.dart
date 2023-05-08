import 'dart:io';
import 'dart:convert';
import 'package:dart_space_adventure/dart_space_adventure.dart';

void main(List<String> arguments) {
  String filename = arguments[0];
  File(filename).readAsString().then((String json) {
    SpaceAdventure(
      planetarySystem: PlanetarySystem.fromMap(jsonDecode(json))
    ).start();
  });
}