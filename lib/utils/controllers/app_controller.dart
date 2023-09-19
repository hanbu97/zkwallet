// All the things about notificaion

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import '/utils/log/logger.dart';
import 'package:flutter/material.dart';

class AppController extends GetxController {
  var isRunningBackground = false;
  var backgroundSubject = PublishSubject<bool>();
  var isAppBadgeSupported = false;

  late BaseDeviceInfo deviceInfo;

  Future<void> runningBackground(bool run) async {
    LogUtil.debug('-----App running background : $run-------------');

    if (isRunningBackground && !run) {}
    // OpenIM.iMManager.setAppBackgroundStatus(isBackground: run);
    isRunningBackground = run;
    backgroundSubject.sink.add(run);
  }

  @override
  void onInit() async {
    isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    super.onInit();
  }

  Locale? getLocale() {
    var local = Get.locale;
    return local;
  }

  void showBadge(count) {
    if (isAppBadgeSupported) {
      if (count == 0) {
        removeBadge();
        // PushController.resetBadge();
      } else {
        FlutterAppBadger.updateBadgeCount(count);
        // PushController.setBadge(count);
      }
    }
  }

  void removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  @override
  void onClose() {
    backgroundSubject.close();
    // _stopForegroundService();
    // closeSubject();
    // _audioPlayer.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    LogUtil.debug('_getDeviceInfo();');

    // autoCheckVersionUpgrade();
    LogUtil.debug('onReady();');
    super.onReady();
    LogUtil.debug('all();');
  }

  void _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfo = await deviceInfoPlugin.deviceInfo;
  }
}
