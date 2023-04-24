import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pso2_mod_manager/classes/category_class.dart';

String binDirPath = '';
String mainModManDirPath = '';
String mainModDirPath = '';
String modsDirPath = '';
String backupDirPath = '';
String checksumDirPath = '';
String modSettingsPath = '';
String modSetsSettingsPath = '';
String deletedItemsPath = '';
String langSettingsPath = '';
//String curLanguageDirPath = '';
String curActiveLang = '';
List<String> langDropDownList = [];
String langDropDownSelected = '';
List<String> topBtnMenuItems = [];
String s = '/';
String appVersion = '';
int refSheetsVersion = -1;
String? checkSumFilePath;
FilePickerResult? checksumLocation;
bool previewWindowVisible = true;
double windowsWidth = 1280.0;
double windowsHeight = 720.0;
//Future? filesData;
Directory dataDir = Directory('');
List<File> iceFiles = [];
//List<ModFile> allModFiles = [];
var dataStreamController = StreamController();
TextEditingController newSetTextController = TextEditingController();
TextEditingController newLangTextController = TextEditingController();
final newSetFormKey = GlobalKey<FormState>();
List<String> localRefSheetsList = [];
bool firstTimeUser = false;
String versionToSkipUpdate = '';
String? localChecksumMD5;
String? win32ChecksumMD5;
String win32CheckSumFilePath = '';
List<String> ogDataFilePaths = [];
//
List<Category> itemCategories = [];
//
List<String> itemCategoryGroups = [];