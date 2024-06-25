// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pso2_mod_manager/classes/category_class.dart';
import 'package:pso2_mod_manager/classes/category_type_class.dart';
import 'package:pso2_mod_manager/classes/item_class.dart';
import 'package:pso2_mod_manager/classes/mod_class.dart';
import 'package:pso2_mod_manager/classes/mod_file_class.dart';
import 'package:pso2_mod_manager/classes/sub_mod_class.dart';
import 'package:pso2_mod_manager/functions/icon_overlay.dart';
import 'package:pso2_mod_manager/functions/json_write.dart';
import 'package:pso2_mod_manager/functions/modfiles_apply.dart';
import 'package:pso2_mod_manager/functions/restore_functions.dart';
import 'package:pso2_mod_manager/global_variables.dart';
import 'package:pso2_mod_manager/loaders/language_loader.dart';
import 'package:pso2_mod_manager/loaders/paths_loader.dart';
import 'package:pso2_mod_manager/state_provider.dart';

Future<void> quickModsRemoval(context) async {
  File appliedModsFile = File(modManAppliedModsJsonPath);
  if (!appliedModsFile.existsSync()) {
    await appliedModsFile.create();
    if (appliedModsFile.existsSync()) {
      moddedItemsList.where((e) => e.getNumOfAppliedCates() > 0).map((cateType) => cateType.toJson()).toList();
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      appliedModsFile.writeAsStringSync(encoder.convert(moddedItemsList));
      List<ModFile> allModFilesInAppliedList = [];
      for (var type in moddedItemsList) {
        if (type.getNumOfAppliedCates() > 0) {
          for (var cate in type.categories) {
            if (cate.getNumOfAppliedItems() > 0) {
              for (var item in cate.items) {
                if (item.applyStatus) {
                  for (var mod in item.mods) {
                    if (mod.applyStatus) {
                      for (var submod in mod.submods) {
                        if (submod.applyStatus) {
                          allModFilesInAppliedList.addAll(submod.modFiles.where((e) => e.applyStatus));
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      Provider.of<StateProvider>(context, listen: false).quickApplyStateSet('remove');
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (dialogContext, setState) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (Provider.of<StateProvider>(context, listen: false).quickApplyState == 'remove') {
                  List<ModFile> reappliedModFiles = await restoreOriginalFilesToTheGame(context, allModFilesInAppliedList);
                  List<Item> matchedItems = [];
                  List<Mod> matchedMods = [];
                  List<SubMod> matchedSubmods = [];
                  for (var modFile in reappliedModFiles) {
                    var matchingTypes = moddedItemsList.where((element) => element.categories.where((cate) => cate.categoryName == modFile.category).isNotEmpty);
                    for (var type in matchingTypes) {
                      var matchingCates = type.categories.where((element) => modFile.location.contains(element.location));
                      for (var cate in matchingCates) {
                        var matchingItems = cate.items.where((element) => modFile.location.contains(element.location));
                        for (var item in matchingItems) {
                          if (matchedItems.where((element) => element.location == item.location).isEmpty) {
                            matchedItems.add(item);
                          }
                          var matchingMods = item.mods.where((element) => modFile.location.contains(element.location));
                          for (var mod in matchingMods) {
                            if (matchedMods.where((element) => element.location == mod.location).isEmpty) {
                              matchedMods.add(mod);
                            }
                            var matchingSubmods = mod.submods.where((element) => modFile.location.contains(element.location));
                            for (var submod in matchingSubmods) {
                              if (matchedSubmods.where((element) => element.location == submod.location).isEmpty) {
                                matchedSubmods.add(submod);
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                  for (var item in matchedItems) {
                    for (var mod in item.mods.where((element) => matchedMods.where((e) => e.location == element.location).isNotEmpty)) {
                      for (var submod in mod.submods.where((element) => matchedSubmods.where((e) => e.location == element.location).isNotEmpty)) {
                        if (submod.applyStatus) {
                          // unappliedFileNames += '${item.itemName} > ${mod.modName} > ${submod.submodName}\n';
                          submod.applyStatus = false;
                          submod.applyDate = DateTime(0);
                          previewImages.clear();
                          //videoPlayer.remove(0);
                          previewModName = '';
                        }

                        if (mod.submods.where((element) => element.applyStatus).isEmpty) {
                          mod.applyStatus = false;
                          mod.applyDate = DateTime(0);
                        }
                        if (item.mods.where((element) => element.applyStatus).isEmpty) {
                          item.applyStatus = false;
                          item.applyDate = DateTime(0);
                          if (item.isOverlayedIconApplied!) {
                            await restoreOverlayedIcon(item);
                          }
                        }
                      }
                    }
                  }

                  saveModdedItemListToJson();
                  if (moddedItemsList.where((e) => e.getNumOfAppliedCates() > 0).isEmpty && Provider.of<StateProvider>(context, listen: false).quickApplyState.isNotEmpty) {
                    Navigator.pop(context);
                  }
                }
              });
              return AlertDialog(
                  shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColorLight), borderRadius: const BorderRadius.all(Radius.circular(5))),
                  backgroundColor: Color(context.watch<StateProvider>().uiBackgroundColorValue).withOpacity(0.8),
                  contentPadding: const EdgeInsets.all(10),
                  content: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 250, minWidth: 250, maxHeight: double.infinity, maxWidth: double.infinity),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            curLangText!.uiRemovingAllModsFromTheGame,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const CircularProgressIndicator(),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5),
                        //   child: Text(
                        //     context.watch<StateProvider>().boundaryEditProgressStatus,
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                      ],
                    ),
                  ));
            });
          });
    }
  }
}

Future<void> quickModsReapply(context) async {
  File appliedModsFile = File(modManAppliedModsJsonPath);
  if (appliedModsFile.existsSync()) {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (dialogContext, setState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              //Load list from json
              if (File(modManAppliedModsJsonPath).existsSync()) {
                List<CategoryType> structureFromJson = [];
                String modSettingsFromJson = await File(modManAppliedModsJsonPath).readAsString();
                if (modSettingsFromJson.isNotEmpty) {
                  var jsonData = await jsonDecode(modSettingsFromJson);
                  for (var type in jsonData) {
                    structureFromJson.add(CategoryType.fromJson(type));
                  }
                }
                for (var type in structureFromJson) {
                  if (type.getNumOfAppliedCates() > 0) {
                    int matchingTypeIndex = moddedItemsList.indexWhere((e) => e.groupName == type.groupName);
                    CategoryType matchingType = moddedItemsList[matchingTypeIndex];
                    for (var cate in type.categories) {
                      if (cate.getNumOfAppliedItems() > 0) {
                        int matchingCateIndex = matchingType.categories.indexWhere((e) => e.location == cate.location);
                        Category matchingCate = matchingType.categories[matchingCateIndex];
                        for (var item in cate.items.where((e) => e.applyStatus)) {
                          int matchingItemIndex = matchingCate.items.indexWhere((e) => e.location == item.location);
                          Item matchingItem = matchingCate.items[matchingItemIndex];
                          for (var mod in item.mods.where((e) => e.applyStatus)) {
                            int matchingModIndex = matchingItem.mods.indexWhere((e) => e.location == mod.location);
                            Mod matchingMod = matchingItem.mods[matchingModIndex];
                            for (var submod in mod.submods.where((e) => e.applyStatus)) {
                              int matchingSubmodIndex = matchingMod.submods.indexWhere((e) => e.location == submod.location);
                              SubMod matchingSubmod = matchingMod.submods[matchingSubmodIndex];
                              List<ModFile> modFilesToReApply = [];
                              for (var modFile in submod.modFiles.where((e) => e.applyStatus)) {
                                int matchingModFileIndex = matchingSubmod.modFiles.indexWhere((e) => e.location == modFile.location);
                                ModFile matchingModFile = matchingSubmod.modFiles[matchingModFileIndex];
                                matchingModFile.ogLocations = modFile.ogLocations;
                                modFilesToReApply.add(matchingModFile);
                              }
                              await modFilesApply(context, modFilesToReApply);
                              matchingSubmod.applyStatus = true;
                              matchingSubmod.applyDate = DateTime.now();
                            }
                            matchingMod.applyStatus = true;
                            matchingMod.applyDate = DateTime.now();
                          }
                          matchingItem.applyStatus = true;
                          matchingItem.applyDate = DateTime.now();
                          if (Provider.of<StateProvider>(context, listen: false).markModdedItem &&
                              matchingItem.applyStatus &&
                              matchingItem.icons.isNotEmpty &&
                              !matchingItem.icons.contains('assets/img/placeholdersquare.png')) {
                            await applyOverlayedIcon(context, matchingItem);
                          }
                        }
                      }
                    }
                  }
                }

                saveModdedItemListToJson();
                Provider.of<StateProvider>(context, listen: false).quickApplyStateSet('');
                File(modManAppliedModsJsonPath).deleteSync();
                Navigator.pop(context);
              }
            });
            return AlertDialog(
                shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColorLight), borderRadius: const BorderRadius.all(Radius.circular(5))),
                backgroundColor: Color(context.watch<StateProvider>().uiBackgroundColorValue).withOpacity(0.8),
                contentPadding: const EdgeInsets.all(10),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 250, minWidth: 250, maxHeight: double.infinity, maxWidth: double.infinity),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          curLangText!.uiReApplyingAllModsBackToTheGame,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const CircularProgressIndicator(),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5),
                      //   child: Text(
                      //     context.watch<StateProvider>().boundaryEditProgressStatus,
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                    ],
                  ),
                ));
          });
        });
  }
}