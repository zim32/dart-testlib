import 'dart:io';
import 'package:testlib/testlib.dart';

Future<void> main(List<String> arguments) async {
  final package = await create(Directory.current);
  await package.execute();
}
