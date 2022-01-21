import 'dart:io';
import 'package:packager/packager.dart';
import 'package:pub_semver/pub_semver.dart';

Future<Package> package(Directory packageDir) {
  final libSources = [file("../src/testlib.cpp")];

  return Package.create(
      name: "testlib",
      version: Version.parse("1.0.0"),
      installDir: packageDir,
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
        version: "1.0.0",
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
