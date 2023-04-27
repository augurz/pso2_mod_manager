import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:pso2_mod_manager/global_variables.dart';
import 'package:pso2_mod_manager/loaders/language_loader.dart';
import 'package:pso2_mod_manager/loaders/paths_loader.dart';
import 'package:pso2_mod_manager/main.dart';
import 'package:pso2_mod_manager/state_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MultiSplitViewController _viewsController = MultiSplitViewController(areas: [Area(weight: 0.285), Area(weight: 0.335)]);
  final MultiSplitViewController _verticalViewsController = MultiSplitViewController(areas: [Area(weight: 0.40)]);

  @override
  Widget build(BuildContext context) {
    MultiSplitView mainViews = MultiSplitView(
      controller: _viewsController,
      children: [
        if (!context.watch<StateProvider>().setsWindowVisible) itemsView(),
        if (!context.watch<StateProvider>().setsWindowVisible) modsView(),
        if (context.watch<StateProvider>().setsWindowVisible) setList(),
        if (context.watch<StateProvider>().setsWindowVisible) modInSetList(),
        if (!context.watch<StateProvider>().previewWindowVisible) filesView(),
        if (context.watch<StateProvider>().previewWindowVisible)
          MultiSplitView(
            axis: Axis.vertical,
            controller: _verticalViewsController,
            children: [modPreviewView(), filesView()],
          )
      ],
    );

    MultiSplitViewTheme viewsTheme = MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
            dividerThickness: 4,
            dividerPainter: DividerPainters.dashed(
                //highlightedThickness: 5,
                //thickness: 3,
                //backgroundColor: Theme.of(context).hintColor,
                //size: MediaQuery.of(context).size.height,
                color: Theme.of(context).hintColor,
                highlightedColor: Theme.of(context).primaryColor)),
        child: mainViews);

    return context.watch<StateProvider>().languageReload
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  curLangText!.loadingUIText,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          )
        : viewsTheme;
  }

  Widget itemsView() {
    var searchBoxLeftPadding = 10;
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: searchBoxLeftPadding == 15 ? null : Container(padding: const EdgeInsets.only(bottom: 10), child: Text(curLangText!.itemsHeaderText)),
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColorDark : Theme.of(context).iconTheme.color,
          toolbarHeight: 30,
          elevation: 0,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          //color: Theme.of(context).textTheme.headlineMedium?.color,
        ),
        Expanded(
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Theme.of(context).textTheme.displaySmall?.color?.withOpacity(0.7);
                }
                return Theme.of(context).textTheme.displaySmall?.color?.withOpacity(0.5);
              }),
            ),
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moddedItemsList.length,
                itemBuilder: (context, groupIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groupIndex != 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          //color: Theme.of(context).textTheme.headlineMedium?.color,
                        ),
                      ExpansionTile(
                        title: Text(moddedItemsList[groupIndex].groupName),
                        initiallyExpanded: moddedItemsList[groupIndex].expanded,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: moddedItemsList[groupIndex].categories.length,
                            itemBuilder: (context, categoryIndex) {
                              var curCategory = moddedItemsList[groupIndex].categories[categoryIndex];
                              return ExpansionTile(
                                  initiallyExpanded: false,
                                  childrenPadding: const EdgeInsets.all(0),
                                  textColor: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColor : Colors.white,
                                  iconColor: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColor : Colors.white,
                                  collapsedTextColor: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColor : Colors.white,
                                  collapsedIconColor: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColor : Colors.white,
                                  onExpansionChanged: (newState) {},
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(curCategory.categoryName),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, top: 18, bottom: 13),
                                            child: Container(
                                                padding: const EdgeInsets.only(left: 2, right: 2, bottom: 3),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Theme.of(context).highlightColor),
                                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                ),
                                                child: curCategory.items.length < 2
                                                    ? Text('${moddedItemsList[groupIndex].categories[categoryIndex].items.length}${curLangText!.itemLabelText}',
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ))
                                                    : Text('${curCategory.items.length}${curLangText!.itemsLabelText}',
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ))),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          if (!defaultCateforyDirs.contains(curCategory.categoryName))
                                            Tooltip(
                                                message: '${curLangText!.deleteBtnTooltipText} ${curCategory.categoryName}',
                                                height: 25,
                                                textStyle: TextStyle(fontSize: 15, color: Theme.of(context).canvasColor),
                                                waitDuration: const Duration(seconds: 2),
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: MaterialButton(
                                                      onPressed: (() {
                                                        setState(() {});
                                                      }),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.delete_sweep_rounded,
                                                            color: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                                                          )
                                                        ],
                                                      )),
                                                )),
                                        ],
                                      )
                                    ],
                                  ),
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: curCategory.items.length,
                                        itemBuilder: (context, itemIndex) {
                                          var curItem = curCategory.items[itemIndex];
                                          return SizedBox(
                                            height: 84,
                                            child: Card(
                                              margin: const EdgeInsets.all(1),
                                              color: Theme.of(context).canvasColor,
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                                              child: InkWell(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 15, right: 10),
                                                      child: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(3),
                                                            border: Border.all(color: Theme.of(context).hintColor),
                                                          ),
                                                          child: Image.file(
                                                            File(curItem.icon),
                                                            filterQuality: FilterQuality.none,
                                                            fit: BoxFit.fitWidth,
                                                          )),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            curItem.itemName,
                                                            style: const TextStyle(fontSize: 16),
                                                          ),
                                                          Text(
                                                            '${curLangText!.modscolonLableText} ${curItem.mods.length}',
                                                            style: TextStyle(color: Theme.of(context).textTheme.displaySmall?.color),
                                                          ),
                                                          Text(
                                                            '${curLangText!.fileAppliedColonLabelText} ${curItem.mods.where((element) => element.applyStatus == true).length}',
                                                            style: TextStyle(color: Theme.of(context).textTheme.displaySmall?.color),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 15),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          if (curItem.isNew)
                                                            SizedBox(
                                                                height: 50,
                                                                child:
                                                                    Icon(Icons.new_releases, color: MyApp.themeNotifier.value == ThemeMode.light ? Theme.of(context).primaryColorDark : Colors.amber)),

                                                          //Buttons
                                                          Tooltip(
                                                              message: '${curLangText!.openBtnTooltipText}${curItem.itemName}${curLangText!.inExplorerBtnTootipText}',
                                                              height: 25,
                                                              textStyle: TextStyle(fontSize: 15, color: Theme.of(context).canvasColor),
                                                              waitDuration: const Duration(seconds: 2),
                                                              child: SizedBox(
                                                                width: 34,
                                                                height: 50,
                                                                child: MaterialButton(
                                                                    onPressed: (() async {
                                                                      await launchUrl(Uri.parse('file:${curItem.location}'));
                                                                    }),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons.folder_open_rounded,
                                                                          size: 18,
                                                                        )
                                                                      ],
                                                                    )),
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          );
                                        }),
                                  ]);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget modsView() {
    return Container();
  }
}

Widget setList() {
  return Container();
}

Widget modInSetList() {
  return Container();
}

Widget filesView() {
  return Container();
}

Widget modPreviewView() {
  return Container();
}
