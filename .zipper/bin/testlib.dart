import 'dart:io';
import 'package:testlib/testlib.dart';

Future<void> main(List<String> arguments) async {
  final task = await package(Directory.current);
  await task.execute();
}
