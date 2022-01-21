import 'dart:io';
import 'package:packager/packager.dart';
import 'package:pub_semver/pub_semver.dart';

Future<Package> package(Directory packageDir) {
  final libSources = [file("../src/testlib.cpp")];
  final version = "1.0.0";

  return Package.create(
      name: "testlib",
      version: Version.parse(version),
      buildParentPackage: (package) {
        package.providers.add(
          CppFlagsProvider(flags: {
            "-ltestlib",
            "-L${dir('.').path}",
            "-I${dir('../src').path}"
          }),
        );
      },
      buildTask: CompileCppLibrary(
        sourceFiles: libSources,
        libName: "testlib",
        soName: "libtestlib.so.1",
        type: CppLibraryType.shared,
        version: version,
      ),
      installTask: ExecTask(
        build: (builder, self) {
          builder.appendAllMul([
            ["cp", packageDir.path + "/libtestlib.so", "."],
            ["cp", packageDir.path + "/libtestlib.so.1", "."],
            ["cp", packageDir.path + "/libtestlib.so.1.0", "."],
            ["cp", packageDir.path + "/libtestlib.so.1.0.0", "."],
          ]);
        },
      ));
}
