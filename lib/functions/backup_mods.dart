import 'dart:io';

import 'package:pso2_mod_manager/classes/mod_file_class.dart';
import 'package:pso2_mod_manager/functions/hash_generator.dart';
import 'package:pso2_mod_manager/loaders/paths_loader.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

Future<ModFile> modFileBackup(ModFile modFile) async {
  for (var ogPath in modFile.ogLocations) {
    final newBackupPath = ogPath.replaceFirst(Uri.file('$modManPso2binPath/data').toFilePath(), modManBackupsDirPath);

    //if (!File(newBackupPath).existsSync() || (!modFile.ogMd5s.contains(newOGMD5) && newOGMD5 != modFile.md5)) {
    if (!File(newBackupPath).existsSync()) {
      Directory(p.dirname(newBackupPath)).createSync(recursive: true);
      File(ogPath).copySync(
        newBackupPath,
      );
    }
    String newOGMD5 = await getFileHash(ogPath);
    if (!modFile.ogMd5s.contains(newOGMD5)) {
      modFile.ogMd5s.add(newOGMD5);
    }
    if (!modFile.bkLocations.contains(newBackupPath)) {
      modFile.bkLocations.add(newBackupPath);
    }
  }
  return modFile;
}
