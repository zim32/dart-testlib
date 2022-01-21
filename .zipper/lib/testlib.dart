import 'dart:io';
import 'package:packager/packager.dart';
import 'package:pub_semver/pub_semver.dart';

Future<Package> create(Directory rootDir, [bool buildSelf = true]) {
  final libSources = [file("../src/testlib.cpp")];

  if (!buildSelf) {
    CompileCppLibrary.compilerFlags.addAll(["-L${rootDir.path}", "-ltestlib"]);
    CompileCppBinary.compilerFlags.addAll(["-L${rootDir.path}", "-ltestlib"]);
  }

  return Package.create(
    name: "testlib",
    version: Version.parse("1.0.0"),
    buildTask: CompileCppLibrary(
      sourceFiles: libSources,
      libName: "testlib",
      soName: "libtestlib.so.1",
      type: CppLibraryType.shared,
      version: "1.0.0",
    ),
    installTask: NoopTask(),
  );
}
