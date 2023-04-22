import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pso2_mod_manager/loaders/language_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

//All paths go here
//Main paths
String pso2binPath = '';
String modManDirParentDirPath = '';
String modManDirPath = '';
String modManModsDirPath = '';
String modManBackupsDirPath = '';
String modManChecksumDirPath = '';
String modManDeletedItemsDirPath = '';
//Misc path
String modManAddModsTempDirPath = '';
String modManAddModsUnpackDirPath = '';
String zamboniExePath = Uri.file('${Directory.current.path}/Zamboni/Zamboni.exe').toFilePath();
String refSheetsDirPath = Uri.directory('${Directory.current.path}/ItemRefSheets').toFilePath();
//Json files path
String modManModsListJsonPath = '';
String modManModSetsJsonPath = '';
String modManModSettingsJsonPath = '';

//Default Mod Caterories
List<String> defaultCateforyDirs = [
  'Accessories',
  'Basewears',
  'Body Paints',
  'Cast Arm Parts',
  'Cast Body Parts',
  'Cast Leg Parts',
  'Costumes',
  'Emotes',
  'Eyes',
  'Face Paints',
  'Hairs',
  'Innerwears',
  'Mags',
  'Misc',
  'Motions',
  'Outerwears',
  'Setwears'
];

Future<bool> pathsLoader(context) async {
  final prefs = await SharedPreferences.getInstance();
  //pso2_bin path
  pso2binPath = Uri.file(prefs.getString('binDirPath') ?? '').toFilePath();
  while (pso2binPath.isEmpty) {
    String? pso2binPathFromPicker = await pso2binPathGet(context);
    if (pso2binPathFromPicker != null) {
      pso2binPath = Uri.file(pso2binPathFromPicker).toFilePath();
    }
  }
  //modman dir path
  modManDirParentDirPath = Uri.file(prefs.getString('mainModManDirPath') ?? '').toFilePath();
  while (modManDirParentDirPath.isEmpty) {
    String? modManDirPathFromPicker = await modManDirPathGet(context);
    if (modManDirPathFromPicker != null) {
      modManDirParentDirPath = Uri.file(modManDirPathFromPicker).toFilePath();
    } else {
      modManDirParentDirPath = pso2binPath;
    }
  }

  //Create modman folder if not already existed
  modManDirPath = Uri.file('$modManDirParentDirPath/PSO2 Mod Manager').toFilePath();
  Directory(modManDirPath).createSync();
  //Create Mods folder and default categories
  modManModsDirPath = Uri.file('$modManDirPath/Mods').toFilePath();
  for (var name in defaultCateforyDirs) {
    Directory('$modManModsDirPath/$name').createSync();
  }
  //Create Backups folder
  modManBackupsDirPath = Uri.file('$modManDirPath/Backups').toFilePath();
  Directory(modManBackupsDirPath).createSync();
  List<String> dataFolders = ['win32', 'win32_na', 'win32reboot', 'win32reboot_na'];
  for (var name in dataFolders) {
    Directory('$modManBackupsDirPath/$name').createSync();
  }
  //Create Checksum folder
  modManChecksumDirPath = Uri.file('$modManDirPath/Checksum').toFilePath();
  Directory(modManChecksumDirPath).createSync();
  //Create Deleted Items folder
  modManDeletedItemsDirPath = Uri.file('$modManDirPath/Deleted Items').toFilePath();
  Directory(modManDeletedItemsDirPath);
  //Create misc folders
  modManAddModsTempDirPath = Uri.file('${Directory.current.path}/temp').toFilePath();
  Directory(modManAddModsTempDirPath).createSync(recursive: true);
  modManAddModsUnpackDirPath = Uri.file('${Directory.current.path}/unpack').toFilePath();
  Directory(modManAddModsUnpackDirPath).createSync(recursive: true);
  //Create Json files
  modManModsListJsonPath = Uri.file('$modManDirPath/PSO2ModManModsList.json').toFilePath();
  modManModSetsJsonPath = Uri.file('$modManDirPath/PSO2ModManModSets.json').toFilePath();
  modManModSettingsJsonPath = Uri.file('$modManDirPath/PSO2ModManSettings.json').toFilePath();

  //Return true if all paths loaded
  return true;
}

Future<String?> pso2binPathGet(context) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
              titlePadding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
              title: const Center(
                child: Text('Error', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              content: Text(
                curLangText!.pso2binNotFoundPopupText,
              ),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text('Exit'),
                    onPressed: () async {
                      Navigator.pop(context, null);
                      await windowManager.destroy();
                    }),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(
                          context,
                          await FilePicker.platform.getDirectoryPath(
                            dialogTitle: 'Select \'pso2_bin\' folder path',
                            lockParentWindow: true,
                          ));
                    },
                    child: const Text('Yes'))
              ]));
}

Future<String?> modManDirPathGet(context) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
              titlePadding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
              title: Center(
                child: Text(curLangText!.modmanFolderNotFoundLabelText, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              content: Text(
                curLangText!.modmanFolderNotFoundText,
              ),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text('No'),
                    onPressed: () async {
                      Navigator.pop(context, null);
                    }),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(
                          context,
                          await FilePicker.platform.getDirectoryPath(
                            dialogTitle: 'Select a folder to store Mod Manager folder',
                            lockParentWindow: true,
                          ));
                    },
                    child: const Text('Yes'))
              ]));
}