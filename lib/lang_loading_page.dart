
import 'package:flutter/material.dart';

class LangLoadingPage extends StatefulWidget {
  const LangLoadingPage({Key? key}) : super(key: key);

  @override
  State<LangLoadingPage> createState() => _LangLoadingPageState();
}

class _LangLoadingPageState extends State<LangLoadingPage> {
  @override
  void initState() {
    //getUILanguage();
    super.initState();
  }

  // Future<void> getUILanguage() async {
  //   if (langList.isEmpty) {
  //     langList = await translationLoader();
  //     for (var lang in langList) {
  //       langDropDownList.add(lang.langInitial);
  //       if (lang.langFilePath != '$curLanguageDirPath$s${lang.langInitial}.json') {
  //         lang.langFilePath = '$curLanguageDirPath$s${lang.langInitial}.json';
  //         //Json Write
  //         langList.map((translation) => translation.toJson()).toList();
  //         File(langSettingsPath).writeAsStringSync(json.encode(langList));
  //       }
  //       if (lang.selected) {
  //         langDropDownSelected = lang.langInitial;
  //         curSelectedLangPath = '$curLanguageDirPath$s${lang.langInitial}.json';
  //         curActiveLang = lang.langInitial;
  //       }
  //     }
  //   }

  //   if (curLangText == null) {
  //     curLangText = TranslationText.fromJson(jsonDecode(File(modsListJsonPath.toFilePath()).readAsStringSync()))
  //     convertLangTextData(jsonDecode(File(curSelectedLangPath).readAsStringSync()));
  //     //await Future.delayed(const Duration(milliseconds: 500));
  //     setState(() {});
  //   }

  //   topBtnMenuItems = [curLangText!.modsFolderBtnText, curLangText!.backupFolderBtnText, curLangText!.deletedItemsBtnText];
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Loading UI',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}
