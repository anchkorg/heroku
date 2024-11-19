// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:device_info_plus/src/device_info_plus_web.dart';
import 'package:flutter_web_auth_2/src/web.dart';
import 'package:package_info_plus/src/package_info_plus_web.dart';
import 'package:sentry_flutter/sentry_flutter_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:youtube_player_iframe_web/src/web_youtube_player_iframe_platform.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  DeviceInfoPlusWebPlugin.registerWith(registrar);
  FlutterWebAuth2WebPlugin.registerWith(registrar);
  PackageInfoPlusWebPlugin.registerWith(registrar);
  SentryFlutterWeb.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  WebYoutubePlayerIframePlatform.registerWith(registrar);
  registrar.registerMessageHandler();
}
