import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/preacher.dart';
import '../entity/appwrite_file.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class AnchkPreacherNotifier extends StateNotifier<Preacher> {
  AnchkPreacherNotifier(this.apiServce) : super(Preacher(name: "Initial"));
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "AnchkPreacherNotifier";
  final String databaseId = 'default';
  final String collectionId = 'PreachersMessage';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    Preacher underscoreTmp = Preacher(name: "Introduction");
    // Uint8List underscorePhotoTmp = Uint8List(0);
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
    /** 
    if (state.photo == data!.documents[0].data['photo']) {
      underscorePhotoTmp = state.photoFile!;
    } else {
      await apiServce
          .getFile(data.documents[0].data['photo'])
          .then((photofile) async {
        underscorePhotoTmp = photofile;
      });
    }

*/

    underscoreTmp = Preacher(
      name: data!.documents[0].data['name'],
      message: data.documents[0].data['text'],
      photo: data.documents[0].data['photo'],
      // photoFile: underscorePhotoTmp,
    );

    state = underscoreTmp;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${data.total.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final anchkPreacherNotifierProvider =
    StateNotifierProvider<AnchkPreacherNotifier, Preacher>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return AnchkPreacherNotifier(apiServce);
});
