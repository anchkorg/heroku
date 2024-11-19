import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/anchk_mission.dart';
import '../entity/appwrite_file.dart';
import '../entity/paragraph_model.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class AnchkMissionNotifier extends StateNotifier<AnchkMission> {
  AnchkMissionNotifier(this.apiServce) : super(AnchkMission(name: "Initial"));
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "AnchkMissionNotifier";
  final String databaseId = 'default';
  final String collectionId = 'anchkMission';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    AnchkMission underscoreTmp = AnchkMission(name: "Introduction");
//    Uint8List underscorePhotoTmp = Uint8List(0);
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
    await apiServce.getPhoto("anchkMission").then((value) async {
/**
      if (state.photo == value['fileId']) {
        underscorePhotoTmp = state.photoFile!;
      } else {
        await apiServce.getFile(value['fileId']).then((photofile) async {
          underscorePhotoTmp = photofile;
        });
      }
       */
      underscoreTmp = AnchkMission(
        name: "Introduction",
        message: data!
            .convertTo<Paragraph>(
                (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))))
            .toList(),
        photo: value['fileId'],
        //photoFile: underscorePhotoTmp,
      );
    });

    state = underscoreTmp;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${data!.total.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final anchkMissionNotifierProvider =
    StateNotifierProvider<AnchkMissionNotifier, AnchkMission>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return AnchkMissionNotifier(apiServce);
});
