import 'package:pso2_mod_manager/main.dart';

class TranslationLanguage {
  TranslationLanguage(this.langInitial, this.langFilePath, this.selected);

  String langInitial;
  String langFilePath;
  bool selected;

  fromJson(Map<String, dynamic> json) {
    langInitial = json['langInitial'];
    langFilePath = json['langFilePath'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['langInitial'] = langInitial;
    data['langFilePath'] = langFilePath;
    data['selected'] = selected;

    return data;
  }
}

class TranslationText {
  TranslationText(
    //Header buttons
    this.pathsReselectBtnText,
    this.foldersBtnText,
    this.modsFolderBtnText,
    this.backupFolderBtnText,
    this.deletedItemsBtnText,
    this.checksumBtnText,
    this.modSetsBtnText,
    this.modListBtnText,
    this.previewBtnText,
    this.lightModeBtnText,
    this.darkModeBtnText,

    //Header buttons tooltips
    this.pathsReselectTooltipText,
    this.foldersTooltipText,
    this.modsFolderTooltipText,
    this.checksumToolTipText,
    this.modSetsTooltipText,
    this.previewTooltipText,
    this.lightModeTooltipText,
    this.darkModeTooltipText,
    this.languageTooltipText,

    //Main Headers
    this.itemsHeaderText,
    this.availableModsHeaderText,
    this.previewHeaderText,
    this.appliedModsHeadersText,
    this.setsHeaderText,
    this.modsInSetHeaderText,

    //Mod Items
    this.refreshBtnTootipText,
    this.newCatBtnTooltipText,
    this.newItemBtnTooltipText,
    this.inExplorerBtnTootipText,
    this.searchLabelText,
    this.newCatNameLabelText,
    this.newCatNameEmptyErrorText,
    this.newCatNameDupErrorText,
    this.addCatBtnText,
    this.singleAddBtnText,
    this.multiAddBtnText,
    this.singleDropBoxLabelText,
    this.multiDropBoxLabelText,
    this.iconDropBoxLabelText,
    this.addSelectCatLabelText,
    this.addItemNamLabelText,
    this.addModNameLabelText,
    this.favLabelText,
    this.accessoriesLabelText,
    this.basewearsLabelText,
    this.bodypaintsLabelText,
    this.emotesLabelText,
    this.innerLabelText,
    this.miscLabelText,
    this.motionsLabelText,
    this.outerLabelText,
    this.setwearsLabelText,

    //Misc
    this.itemsLabelText,
    this.fileAppliedLabelText,
    this.closeBtnText,
    this.openBtnTooltipText,
    this.addBtnText,
    this.addBtnTooltipText,
    this.removeBtnTooltipText,
    this.deleteBtnTooltipText,
  );

  //Header buttons
  String pathsReselectBtnText;
  String foldersBtnText;
  String modsFolderBtnText;
  String backupFolderBtnText;
  String deletedItemsBtnText;
  String checksumBtnText;
  String modSetsBtnText;
  String modListBtnText;
  String previewBtnText;
  String lightModeBtnText;
  String darkModeBtnText;

  //Header buttons tooltips
  String pathsReselectTooltipText;
  String foldersTooltipText;
  String modsFolderTooltipText;
  String checksumToolTipText;
  String modSetsTooltipText;
  String previewTooltipText;
  String lightModeTooltipText;
  String darkModeTooltipText;
  String languageTooltipText;

  //Main Headers
  String itemsHeaderText;
  String availableModsHeaderText;
  String previewHeaderText;
  String appliedModsHeadersText;
  String setsHeaderText;
  String modsInSetHeaderText;

  //Mod Items
  String refreshBtnTootipText;
  String newCatBtnTooltipText;
  String newItemBtnTooltipText;
  String inExplorerBtnTootipText;
  String searchLabelText;
  String newCatNameLabelText;
  String newCatNameEmptyErrorText;
  String newCatNameDupErrorText;
  String addCatBtnText;
  String singleAddBtnText;
  String multiAddBtnText;
  String singleDropBoxLabelText;
  String multiDropBoxLabelText;
  String iconDropBoxLabelText;
  String addSelectCatLabelText;
  String addItemNamLabelText;
  String addModNameLabelText;
  String favLabelText;
  String accessoriesLabelText;
  String basewearsLabelText;
  String bodypaintsLabelText;
  String emotesLabelText;
  String innerLabelText;
  String miscLabelText;
  String motionsLabelText;
  String outerLabelText;
  String setwearsLabelText;

  //Misc
  String itemsLabelText;
  String fileAppliedLabelText;
  String closeBtnText;
  String openBtnTooltipText;
  String addBtnText;
  String addBtnTooltipText;
  String removeBtnTooltipText;
  String deleteBtnTooltipText;

  fromJson(Map<String, dynamic> json) {
    //Header buttons
    pathsReselectBtnText = json['pathsReselectBtnText'];
    foldersBtnText = json['foldersBtnText'];
    modsFolderBtnText = json['modsFolderBtnText'];
    backupFolderBtnText = json['backupFolderBtnText'];
    deletedItemsBtnText = json['deletedItemsBtnText'];
    checksumBtnText = json['checksumBtnText'];
    modSetsBtnText = json['modSetsBtnText'];
    modListBtnText = json['modListBtnText'];
    previewBtnText = json['previewBtnText'];
    lightModeBtnText = json['lightModeBtnText'];
    darkModeBtnText = json['darkModeBtnText'];

    //Header buttons tooltips
    pathsReselectTooltipText = json['pathsReselectTooltipText'];
    foldersTooltipText = json['foldersTooltipText'];
    modsFolderTooltipText = json['modsFolderTooltipText'];
    checksumToolTipText = json['checksumToolTipText'];
    modSetsTooltipText = json['modSetsTooltipText'];
    previewTooltipText = json['previewTooltipText'];
    lightModeTooltipText = json['lightModeTooltipText'];
    darkModeTooltipText = json['darkModeTooltipText'];
    languageTooltipText = json['languageTooltipText'];

    //Main Headers
    itemsHeaderText = json['itemsHeaderText'];
    availableModsHeaderText = json['availableModsHeaderText'];
    previewHeaderText = json['previewHeaderText'];
    appliedModsHeadersText = json['appliedModsHeadersText'];
    setsHeaderText = json['setsHeaderText'];
    modsInSetHeaderText = json['modsInSetHeaderText'];

    //Mod Items
    refreshBtnTootipText = json['refreshBtnTootipText'];
    newCatBtnTooltipText = json['newCatBtnTooltipText'];
    newItemBtnTooltipText = json['newItemBtnTooltipText'];
    inExplorerBtnTootipText = json['inExplorerBtnTootipText'];
    searchLabelText = json['searchLabelText'];
    newCatNameLabelText = json['newCatNameLabelText'];
    newCatNameEmptyErrorText = json['newCatNameEmptyErrorText'];
    newCatNameDupErrorText = json['newCatNameDupErrorText'];
    addCatBtnText = json['addCatBtnText'];
    singleAddBtnText = json['singleAddBtnText'];
    multiAddBtnText = json['multiAddBtnText'];
    singleDropBoxLabelText = json['singleDropBoxLabelText'];
    multiDropBoxLabelText = json['multiDropBoxLabelText'];
    iconDropBoxLabelText = json['iconDropBoxLabelText'];
    addSelectCatLabelText = json['addSelectCatLabelText'];
    addItemNamLabelText = json['addItemNamLabelText'];
    addModNameLabelText = json['addModNameLabelText'];
    favLabelText = json['favLabelText'];
    accessoriesLabelText = json['accessoriesLabelText'];
    basewearsLabelText = json['basewearsLabelText'];
    bodypaintsLabelText = json['bodypaintsLabelText'];
    emotesLabelText = json['emotesLabelText'];
    innerLabelText = json['innerLabelText'];
    miscLabelText = json['miscLabelText'];
    motionsLabelText = json['motionsLabelText'];
    outerLabelText = json['outerLabelText'];
    setwearsLabelText = json['setwearsLabelText'];

    //Misc
    itemsLabelText = json['itemsLabelText'];
    fileAppliedLabelText = json['fileAppliedLabelText'];
    closeBtnText = json['closeBtnText'];
    openBtnTooltipText = json['openBtnTooltipText'];
    addBtnText = json['addBtnText'];
    addBtnTooltipText = json['addBtnTooltipText'];
    removeBtnTooltipText = json['removeBtnTooltipText'];
    deleteBtnTooltipText = json['deleteBtnTooltipText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //Header buttons
    data['pathsReselectBtnText'] = pathsReselectBtnText;
    data['foldersBtnText'] = foldersBtnText;
    data['modsFolderBtnText'] = modsFolderBtnText;
    data['backupFolderBtnText'] = backupFolderBtnText;
    data['deletedItemsBtnText'] = deletedItemsBtnText;
    data['checksumBtnText'] = checksumBtnText;
    data['modSetsBtnText'] = modSetsBtnText;
    data['modListBtnText'] = modListBtnText;
    data['previewBtnText'] = previewBtnText;
    data['lightModeBtnText'] = lightModeBtnText;
    data['darkModeBtnText'] = darkModeBtnText;

    //Header buttons tooltips
    data['pathsReselectTooltipText'] = pathsReselectTooltipText;
    data['foldersTooltipText'] = foldersTooltipText;
    data['modsFolderTooltipText'] = modsFolderTooltipText;
    data['checksumToolTipText'] = checksumToolTipText;
    data['modSetsTooltipText'] = modSetsTooltipText;
    data['previewTooltipText'] = previewTooltipText;
    data['lightModeTooltipText'] = lightModeTooltipText;
    data['darkModeTooltipText'] = darkModeTooltipText;
    data['languageTooltipText'] = languageTooltipText;

    //Main Headers
    data['itemsHeaderText'] = itemsHeaderText;
    data['availableModsHeaderText'] = availableModsHeaderText;
    data['previewHeaderText'] = previewHeaderText;
    data['appliedModsHeadersText'] = appliedModsHeadersText;
    data['setsHeaderText'] = setsHeaderText;
    data['modsInSetHeaderText'] = modsInSetHeaderText;

    //Mod Items
    data['refreshBtnTootipText'] = refreshBtnTootipText;
    data['newCatBtnTooltipText'] = newCatBtnTooltipText;
    data['newItemBtnTooltipText'] = newItemBtnTooltipText;
    data['inExplorerBtnTootipText'] = inExplorerBtnTootipText;
    data['searchLabelText'] = searchLabelText;
    data['newCatNameLabelText'] = newCatNameLabelText;
    data['newCatNameEmptyErrorText'] = newCatNameEmptyErrorText;
    data['newCatNameDupErrorText'] = newCatNameDupErrorText;
    data['addCatBtnText'] = addCatBtnText;
    data['singleAddBtnText'] = singleAddBtnText;
    data['multiAddBtnText'] = multiAddBtnText;
    data['singleDropBoxLabelText'] = singleDropBoxLabelText;
    data['multiDropBoxLabelText'] = multiDropBoxLabelText;
    data['iconDropBoxLabelText'] = iconDropBoxLabelText;
    data['addSelectCatLabelText'] = addSelectCatLabelText;
    data['addItemNamLabelText'] = addItemNamLabelText;
    data['addModNameLabelText'] = addModNameLabelText;
    data['favLabelText'] = favLabelText;
    data['accessoriesLabelText'] = accessoriesLabelText;
    data['basewearsLabelText'] = basewearsLabelText;
    data['bodypaintsLabelText'] = bodypaintsLabelText;
    data['emotesLabelText'] = emotesLabelText;
    data['innerLabelText'] = innerLabelText;
    data['miscLabelText'] = miscLabelText;
    data['motionsLabelText'] = motionsLabelText;
    data['outerLabelText'] = outerLabelText;
    data['setwearsLabelText'] = setwearsLabelText;

    //Misc
    data['itemsLabelText'] = itemsLabelText;
    data['fileAppliedLabelText'] = fileAppliedLabelText;
    data['closeBtnText'] = closeBtnText;
    data['openBtnTooltipText'] = openBtnTooltipText;
    data['addBtnText'] = addBtnText;
    data['addBtnTooltipText'] = addBtnTooltipText;
    data['removeBtnTooltipText'] = removeBtnTooltipText;
    data['deleteBtnTooltipText'] = deleteBtnTooltipText;

    return data;
  }
}

void convertLangTextData(var jsonResponse) {
  for (var b in jsonResponse) {
    TranslationText translation = TranslationText(
      //Header buttons
      b['pathsReselectBtnText'],
      b['foldersBtnText'],
      b['modsFolderBtnText'],
      b['backupFolderBtnText'],
      b['deletedItemsBtnText'],
      b['checksumBtnText'],
      b['modSetsBtnText'],
      b['modListBtnText'],
      b['previewBtnText'],
      b['lightModeBtnText'],
      b['darkModeBtnText'],

      //Header buttons tooltips
      b['pathsReselectTooltipText'],
      b['foldersTooltipText'],
      b['modsFolderTooltipText'],
      b['checksumToolTipText'],
      b['modSetsTooltipText'],
      b['previewTooltipText'],
      b['lightModeTooltipText'],
      b['darkModeTooltipText'],
      b['languageTooltipText'],

      //Main Headers
      b['itemsHeaderText'],
      b['availableModsHeaderText'],
      b['previewHeaderText'],
      b['appliedModsHeadersText'],
      b['setsHeaderText'],
      b['modsInSetHeaderText'],

      //Mod Items
      b['refreshBtnTootipText'],
      b['newCatBtnTooltipText'],
      b['newItemBtnTooltipText'],
      b['inExplorerBtnTootipText'],
      b['searchLabelText'],
      b['newCatNameLabelText'],
      b['newCatNameEmptyErrorText'],
      b['newCatNameDupErrorText'],
      b['addCatBtnText'],
      b['singleAddBtnText'],
      b['multiAddBtnText'],
      b['singleDropBoxLabelText'],
      b['multiDropBoxLabelText'],
      b['iconDropBoxLabelText'],
      b['addSelectCatLabelText'],
      b['addItemNamLabelText'],
      b['addModNameLabelText'],
      b['favLabelText'],
      b['accessoriesLabelText'],
      b['basewearsLabelText'],
      b['bodypaintsLabelText'],
      b['emotesLabelText'],
      b['innerLabelText'],
      b['miscLabelText'],
      b['motionsLabelText'],
      b['outerLabelText'],
      b['setwearsLabelText'],

      //Misc
      b['itemsLabelText'],
      b['fileAppliedLabelText'],
      b['closeBtnText'],
      b['openBtnTooltipText'],
      b['addBtnText'],
      b['addBtnTooltipText'],
      b['removeBtnTooltipText'],
      b['deleteBtnTooltipText'],
    );
    curLangText = translation;
  }
}