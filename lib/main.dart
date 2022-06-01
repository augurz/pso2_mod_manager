// ignore_for_file: unnecessary_new

import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pso2_mod_manager/mod_classes.dart';
import 'package:pso2_mod_manager/custom_window_button.dart';
import 'package:pso2_mod_manager/home_page.dart';
import 'package:pso2_mod_manager/mods_loader.dart';
import 'package:pso2_mod_manager/state_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pso2_mod_manager/popup_handlers.dart';

String binDirPath = '';
String mainModDirPath = '';
String modsDirPath = '';
String backupDirPath = '';
String checksumDirPath = '';
String modSettingsPath = '';
Future? filesData;
List<ModFile> allModFiles = [];
var dataStreamController = StreamController();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => stateProvider()),
  ], child: const MyApp()));
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = const Size(852, 480);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'PSO2NGS Mod Manager';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imgStream = StreamController();

  @override
  void initState() {
    dirPathCheck();
    super.initState();
  }

  void dirPathCheck() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    binDirPath = prefs.getString('binDirPath') ?? '';

    if (binDirPath.isEmpty) {
      getDirPath();
    } else {
      //Fill in paths
      mainModDirPath = '$binDirPath\\PSO2 Mod Manager';
      modsDirPath = '$mainModDirPath\\Mods';
      backupDirPath = '$mainModDirPath\\Backups';
      checksumDirPath = '$mainModDirPath\\Checksum';
      modSettingsPath = '$mainModDirPath\\PSO2ModManSettings.json';
      //Check if exist, create dirs
      if (!Directory(mainModDirPath).existsSync()) {
        await Directory(mainModDirPath).create(recursive: true);
      }
      if (!Directory(modsDirPath).existsSync()) {
        await Directory(modsDirPath).create(recursive: true);
      }
      if (!Directory(backupDirPath).existsSync()) {
        await Directory(backupDirPath).create(recursive: true);
      }
      if (!Directory(checksumDirPath).existsSync()) {
        await Directory(checksumDirPath).create(recursive: true);
      }
      if (!File(modSettingsPath).existsSync()) {
        await File(modSettingsPath).create(recursive: true);
      }
      setState(() {
        context.read<stateProvider>().mainBinFoundTrue();
      });
    }
  }

  void getDirPath() {
    const CustomPopups().binDirDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.black,
        width: 1,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: [
                    Expanded(
                        child: MoveWindow(
                      child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'PSO2NGS Mod Manager',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                    )),
                    const WindowButtons(),
                  ],
                ),
              ),
            ),
            context.watch<stateProvider>().isMainBinFound
                ? FutureBuilder(
                    future: modsLoader(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          allModFiles = snapshot.data;
                          cateList = categories(allModFiles);
                          print('${allModFiles.length} iceFiles Loaded');

                          return const HomePage();
                        }
                      }
                    })
                : Column(
                    children: const [
                      Text(
                        'Waiting for user action',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
          ],
        ),
      ),
      //bottomNavigationBar: const CustomBottomAppBar(
      //fabLocation: _fabLocation,
      //shape: _showNotch ? const CircularNotchedRectangle() : null,
      //  ),
    );
  }
}
