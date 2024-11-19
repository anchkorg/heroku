import '../shared/app_constants.dart';
//import 'dart:typed_data';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/paragraph_model.dart';
import '../entity/practice_info.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class PracticeInfoNotifier extends StateNotifier<PracticeInfo> {
  PracticeInfoNotifier(this.apiServce) : super(PracticeInfo());
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "PracticeInfoNotifier";
  final String databaseId = 'default';
  final String practiceTimeCollectionId = 'practiceTime';
  final String practicePlaceCollectionId = 'practicePlace';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
//    Uint8List underscorePhotoTmp = Uint8List(0);
    DocumentList? practiceTimeRes;
    DocumentList? practicePlaceRes;
    List<Paragraph>? practiceTimeTmp;
    List<Paragraph>? practicePlaceTmp;
    PracticeInfo? underscoreTmp;

    practiceTimeRes = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: practiceTimeCollectionId,
      queries: queries,
    );
    practicePlaceRes = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: practicePlaceCollectionId,
      queries: queries,
    );
    practicePlaceTmp = practicePlaceRes!.convertTo<Paragraph>(
        (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
    practiceTimeTmp = practiceTimeRes!.convertTo<Paragraph>(
        (p0) => Paragraph.fromMap((Map<String, dynamic>.from(p0))));
    await apiServce.getPhoto("practicePlace").then((value) async {
      /** if (state.photo == value['fileId']) {
        // underscorePhotoTmp = state.photoFile!;
      } else {
         await apiServce.getFile(value['fileId']).then((photofile) async {
          underscorePhotoTmp = photofile;
        });
         
      }*/

      underscoreTmp = PracticeInfo(
        practicePlace: practicePlaceTmp,
        practiceTime: practiceTimeTmp,
        photo: value['fileId'],
        //photoFile: underscorePhotoTmp,
      );
    });

    state = underscoreTmp!;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data PracticeInfoNotifier is ${underscoreTmp!.photo.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final practiceInfoNotifierProvider =
    StateNotifierProvider<PracticeInfoNotifier, PracticeInfo>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return PracticeInfoNotifier(apiServce);
});
