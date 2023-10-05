import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '/utils/config/styles.dart';
import 'package:get/get.dart';

import '../../../models/wallet/wallet_types.dart';

class ConfigWallet extends StatefulWidget {
  const ConfigWallet({super.key});

  @override
  State<ConfigWallet> createState() => _ConfigWalletState();
}

class _ConfigWalletState extends State<ConfigWallet> {
  List<WalletType> _walletTypes = [];
  var _archive = [];
  var _starList = [];
  var _isReorder = false;

  @override
  void initState() {
    super.initState();
  }

  void _showWalletTypeDetails(WalletType walletType) {
    print(walletType.toJson().toString());
    // Navigate to a new screen to show the details of the wallet type.
  }

  void _setTop(int index, WalletType type) {
    if (_starList.contains(type)) {
      setState(() {
        _starList.remove(type);
      });

      return;
    }

    setState(() {
      final walletType = _walletTypes.removeAt(index);
      _walletTypes.insert(0, walletType);
      _starList.add(type);
    });
  }

  void _startSorting(int index) {
    setState(() {
      _walletTypes.removeAt(index);
    });
  }

  void _stopSorting() {
    setState(() {
      _walletTypes.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void _archiveItem(int index) {
    setState(() {
      final walletType = _walletTypes.removeAt(index);
      _archive.add(walletType);
    });
  }

  Future<bool> _confirmDismiss() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you want to archive this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('ARCHIVE'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> genList() {
    List<Widget> out = [];

    for (int index = 0; index < _walletTypes.length; index++) {
      final WalletType type = _walletTypes[index];
      out.add(Container(
        key: ValueKey(type),
        child: Column(
          children: [
            if (_isReorder)
              Container(
                color: Colors.white,
                child: ListTile(
                    title: Text(type.name),
                    subtitle: Text(type.family),
                    onTap: () => _showWalletTypeDetails(type),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_starList.contains(type))
                          const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 244, 170, 59),
                          )
                        else
                          const Icon(Icons.star_outline)
                      ],
                    ),
                    trailing: const Icon(Icons.reorder)),
              )
            else
              Dismissible(
                  key: ValueKey(type),
                  onDismissed: (direction) => _archiveItem(index),
                  confirmDismiss: (_) => _confirmDismiss(),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(type.name),
                      subtitle: Text(type.family),
                      onTap: () => _showWalletTypeDetails(type),
                      onLongPress: () => _setTop(index, type),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_starList.contains(type))
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 244, 170, 59),
                            )
                          else
                            const Icon(Icons.star_outline)
                        ],
                      ),
                    ),
                  )),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ));
    }

    return out;
  }

  Future<bool> _confirmReset() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'.tr),
          content:
              Text('Are you sure you want to reset networks to default?'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL'.tr),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('RESET'.tr),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleReset() async {
    // final appState = Provider.of<AppState>(context, listen: false);

    bool shouldReset = await _confirmReset();
    if (shouldReset) {
      // final allNetworks = await appState.resetNetworks();
      // print(allNetworks);

      // setState(() {
      //   _walletTypes = allNetworks;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<AppState>(context, listen: false);
    // _walletTypes = appState.allNetworks;

    return Scaffold(
        backgroundColor: Styles.mainWhite,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Wallet Types"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      elevation: MaterialStatePropertyAll(0)),
                  onPressed: () => {_handleReset()},
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.refresh),
                        ),
                      ),
                      Text(
                        "Reset",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      elevation: MaterialStatePropertyAll(0)),
                  onPressed: () => {
                    setState(() {
                      _isReorder = !_isReorder;
                    })
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: _isReorder
                              ? Icon(Icons.done)
                              : Icon(Icons.wifi_protected_setup),
                        ),
                      ),
                      Text(
                        _isReorder ? "Finish" : "Order",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        body: Container(
          color: Styles.backgroundColor,
          child: ReorderableListView(
            shrinkWrap: true,
            children: <Widget>[...genList()],
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var child = _walletTypes.removeAt(oldIndex);
              _walletTypes.insert(newIndex, child);
              setState(() {});
            },
          ),
        )

        // ReorderableList(
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       final walletType = _walletTypes[index];
        //       return Dismissible(
        //         key: Key(walletType.name),
        //         confirmDismiss: (_) => _confirmDismiss(),
        //         direction: DismissDirection.startToEnd,
        //         onDismissed: (direction) => _archiveItem(index),
        //         background: Container(
        //           color: backgroundBlue,
        //           child: Icon(Icons.archive),
        //           alignment: Alignment.centerLeft,
        //           padding: EdgeInsets.only(left: 16.0),
        //         ),
        //         child: Column(
        //           children: [
        //             Container(
        //               color: Colors.white,
        //               child: ListTile(
        //                 key: ValueKey(walletType.name),
        //                 title: Text(walletType.name),
        //                 subtitle: Text(walletType.family),
        //                 onTap: () => _showWalletTypeDetails(walletType),
        //                 onLongPress: () => _setTop(index),
        //                 trailing: LongPressDraggable(
        //                   child: Icon(Icons.drag_handle),
        //                   feedback: Icon(Icons.drag_handle),
        //                   onDragStarted: () => _startSorting(index),
        //                   onDragEnd: (_) => setState(() => _stopSorting()),
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 5,
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //     itemCount: _walletTypes.length,
        //     onReorder: (int oldIndex, int newIndex) {
        //       setState(() {
        //         if (oldIndex < newIndex) {
        //           newIndex -= 1;
        //         }
        //         final WalletType item = _walletTypes.removeAt(oldIndex);
        //         _walletTypes.insert(newIndex, item);
        //       });
        //     }),

        );
  }
}

// Center(
//                 child: TextButton(
//                   child: Container(
//                       width: double.infinity,
//                       color: filBlue,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(30),
//                             child: Text(
//                               "123",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           )
//                         ],
//                       )),
//                   onPressed: () async {
//                     final manifest =
//                         await rootBundle.loadString('AssetManifest.json');
//                     final fileNames =
//                         Map<String, dynamic>.from(json.decode(manifest))
//                             .keys
//                             .where((String key) =>
//                                 key.startsWith('assets/wallet_types/'))
//                             .toList();

//                     final walletTypes = await loadWalletTypes();
//                     for (final w in walletTypes) {
//                       print(w.toJson());
//                     }
//                   },
//                 ),
//               ),
