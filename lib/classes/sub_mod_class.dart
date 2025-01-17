import 'package:pso2_mod_manager/classes/mod_file_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_mod_class.g.dart';

@JsonSerializable()
class SubMod {
  SubMod(this.submodName, this.modName, this.itemName, this.category, this.location, this.applyStatus, this.applyDate, this.position, this.isNew, this.isFavorite, this.isSet, this.hasCmx,
      this.cmxApplied, this.cmxStartPos, this.cmxEndPos, this.cmxFile, this.setNames, this.previewImages, this.previewVideos, this.appliedModFiles, this.modFiles);
  String submodName;
  String modName;
  String itemName;
  String category;
  String location;
  bool applyStatus;
  DateTime applyDate;
  int position;
  bool isNew;
  bool isFavorite;
  bool isSet;
  bool? hasCmx = false;
  bool? cmxApplied = false;
  int? cmxStartPos = -1;
  int? cmxEndPos = -1;
  String? cmxFile = '';
  List<String> setNames;
  List<String> previewImages;
  List<String> previewVideos;
  List<ModFile> appliedModFiles;
  List<ModFile> modFiles;

  List<String> getModFileNames() {
    List<String> names = [];
    for (var modFile in modFiles) {
      if (!names.contains(modFile.modFileName)) {
        names.add(modFile.modFileName);
      }
    }
    return names;
  }

  List<String> getDistinctModFilePaths() {
    List<String> paths = [];
    for (var modFile in modFiles) {
      if (!paths.contains(modFile.location)) {
        paths.add(modFile.location);
      }
    }
    return paths;
  }

  bool getModFilesAppliedState() {
    final appliedModFiles = modFiles.where((element) => element.applyStatus);
    if (appliedModFiles.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool getModFilesIsNewState() {
    if (modFiles.where((element) => element.isNew).isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  factory SubMod.fromJson(Map<String, dynamic> json) => _$SubModFromJson(json);
  Map<String, dynamic> toJson() => _$SubModToJson(this);
}
