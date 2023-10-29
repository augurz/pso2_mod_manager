import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pso2_mod_manager/application.dart';
import 'package:pso2_mod_manager/global_variables.dart';
import 'package:pso2_mod_manager/loaders/language_loader.dart';
import 'package:pso2_mod_manager/state_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

double _downloadPercent = 0;
String _downloadErrorMsg = '';

Future<void> patchNotesDialog(context) async {
  return showDialog<void>(
    context: context, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColorLight), borderRadius: const BorderRadius.all(Radius.circular(5))),
        backgroundColor: Color(context.watch<StateProvider>().uiBackgroundColorValue).withOpacity(0.8),
        titlePadding: const EdgeInsets.only(top: 10),
        title: Center(child: Text(curLangText!.uiPatchNotes)),
        contentPadding: const EdgeInsets.all(10),
        content: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [for (int index = 0; index < patchNoteSplit.length; index++) Text('- ${patchNoteSplit[index]}')],
        )),
        actions: <Widget>[
          ElevatedButton(
            child: Text(curLangText!.uiClose),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(curLangText!.uiDownloadUpdate),
            onPressed: () {
              Navigator.of(context).pop();
              appDownloadDialog(context);
            },
          ),
        ],
      );
    },
  );
}

Future<void> appDownloadDialog(context) async {
  Dio dio = Dio();

  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (dialogContext, setState) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (_downloadPercent <= 0 && _downloadErrorMsg.isEmpty) {
            try {
              await dio.download('https://github.com/KizKizz/pso2_mod_manager/releases/download/v$newVersion/PSO2NGSModManager_v$newVersion.zip',
                  Uri.file('${Directory.current.path}/appUpdate/PSO2NGSModManager_v$newVersion.zip').toFilePath(), options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
                  onReceiveProgress: (received, total) async {
                if (total != -1) {
                  _downloadPercent = received / total * 100;
                  if (_downloadPercent >= 100) {
                    await Future.delayed(const Duration(milliseconds: 100));
                    await extractFileToDisk(Uri.file('${Directory.current.path}/appUpdate/PSO2NGSModManager_v$newVersion.zip').toFilePath(),
                        Uri.file('${Directory.current.path}/appUpdate/PSO2NGSModManager_v$newVersion').toFilePath(),
                        asyncWrite: false);
                    File patchFile = await patchFileGenerate();
                    Process.run(patchFile.path, []);
                    windowManager.destroy();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                  setState(
                    () {},
                  );
                }
              });
            } catch (e) {
              setState(
                () {
                  _downloadErrorMsg = e.toString();
                },
              );
            }
          }
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColorLight), borderRadius: const BorderRadius.all(Radius.circular(5))),
          backgroundColor: Color(context.watch<StateProvider>().uiBackgroundColorValue).withOpacity(0.8),
          titlePadding: const EdgeInsets.only(top: 10),
          title: Center(child: _downloadErrorMsg.isEmpty ? Text(curLangText!.uiDownloadUpdate) : Text('${curLangText!.uiDownloading} ${curLangText!.uiUpdate} ${curLangText!.uiError}')),
          contentPadding: const EdgeInsets.all(10),
          content: _downloadErrorMsg.isNotEmpty
              ? Text(_downloadErrorMsg)
              : Stack(
                  alignment: Alignment.center,
                  children: [const SizedBox(width: 60, height: 60, child: CircularProgressIndicator()), Text('${_downloadPercent.toStringAsFixed(0)} %')],
                ),
          actions: <Widget>[
            Visibility(
              visible: _downloadErrorMsg.isNotEmpty,
              child: ElevatedButton(
                child: Text(curLangText!.uiGoToDownloadPage),
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/KizKizz/pso2_mod_manager/releases'));
                  dio.close();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: _downloadErrorMsg.isNotEmpty,
              child: ElevatedButton(
                child: Text(curLangText!.uiClose),
                onPressed: () {
                  dio.close();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      });
    },
  );
}

Future<File> patchFileGenerate() async {
  File patchFile = File(Uri.file('${Directory.current.path}/appUpdate/filesPatcher.bat').toFilePath());
  if (!patchFile.existsSync()) {
    patchFile.createSync(recursive: true);
  }
  String commands =
      'xcopy "${Uri.file('${Directory.current.path}/appUpdate/PSO2NGSModManager_v$newVersion/PSO2NGSModManager').toFilePath().toString()}" "${Uri.file(Directory.current.path).toFilePath().toString()}" /Y /E /H /C /I\nstart "${Uri.file('${Directory.current.path}/PSO2NGSModManager.exe').toFilePath().toString()}"';
  await patchFile.writeAsString(commands);

  return patchFile;
}

Future<void> appUpdateSuccessDialog(context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColorLight), borderRadius: const BorderRadius.all(Radius.circular(5))),
        backgroundColor: Color(context.watch<StateProvider>().uiBackgroundColorValue).withOpacity(0.8),
        titlePadding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        title: Center(child: Text(curLangText!.uiMMUpdate)),
        contentPadding: const EdgeInsets.all(10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${curLangText!.uiMMUpdateSuccess}!!',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text('${curLangText!.uiVersion}: $appVersion')
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(curLangText!.uiGitHubPage),
            onPressed: () {
              Provider.of<StateProvider>(context, listen: false).isUpdateAvailableFalse();
              launchUrl(Uri.parse('https://github.com/KizKizz/pso2_mod_manager#readme'));
            },
          ),
          ElevatedButton(
            child: Text(curLangText!.uiClose),
            onPressed: () async {
              Provider.of<StateProvider>(context, listen: false).isUpdateAvailableFalse();
              final prefs = await SharedPreferences.getInstance();
              savedAppVersion = appVersion;
              prefs.setString('savedAppVersion', savedAppVersion);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}