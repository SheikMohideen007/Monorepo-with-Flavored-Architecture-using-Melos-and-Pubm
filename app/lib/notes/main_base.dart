import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_base/notes_base.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) {
  // if (args.isEmpty) {
  //   print('Usage: dart run replace_pubspec.dart <flavor>');
  //   exit(1);
  // }
  // final flavor = args[0];
  // final flavorFile = File('pubspec_$flavor.yaml');
  // final rootFile = File('pubspec.yaml');

  // if (!flavorFile.existsSync()) {
  //   print('Flavor file not found: pubspec_$flavor.yaml');
  //   exit(1);
  // }

  // final yamlStr = flavorFile.readAsStringSync();
  // final yamlMap = loadYaml(yamlStr) as Map;
  // rootFile.writeAsStringSync(yamlStr); // Full dump

  // print('Replaced root with $flavor flavor.');
  // Process.runSync('flutter', ['pub', 'get']);
  runApp(NotesHome());
}
