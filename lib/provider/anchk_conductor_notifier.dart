import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/conductor.dart';
import '../entity/appwrite_file.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class AnchkConductorNotifier extends StateNotifier<List<Conductor>> {
  AnchkConductorNotifier(this.apiServce) : super([]);
//class AnchkConductorNotifier extends StateNotifier<Conductor> {
  //AnchkConductorNotifier(this.apiServce) : super(Conductor(name: "Initial"));

  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "AnchkConductorNotifier";
  final String databaseId = 'default';
  final String collectionId = 'conductorMessage';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    //Conductor underscoreTmp = Conductor(name: "Introduction");
    List<Conductor> underscoreTmp = [];
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
    for (var i in data!.documents) {
      //Uint8List underscorePhotoTmp = Uint8List(0);

      //  if (state.isEmpty ||
      //      state[data.documents.indexOf(i)].photo == i.data['photo']) {
      //    underscorePhotoTmp = state[data.documents.indexOf(i)].photoFile!;
      //  } else {
      /**
      int photoIdCheckIndex = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == i.data['photo']);
      if (photoIdCheckIndex >= 0) {
        underscorePhotoTmp = appwriteFilePool![photoIdCheckIndex].file!;
      } else {
        await apiServce.getFile(i.data['photo']).then((photofile) async {
          underscorePhotoTmp = photofile;
        });
      }
       */
      underscoreTmp.add(Conductor(
        name: i.data['name'],
        message: i.data['text'],
        photo: i.data['photo'],
//        photoFile: underscorePhotoTmp,
      ));
      state.add(Conductor(
        name: i.data['name'],
        message: i.data['text'],
        photo: i.data['photo'],
//        photoFile: underscorePhotoTmp,
      ));
    }
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
    underscoreTmp = Conductor(
      name: data.documents[0].data['name'],
      message: data.documents[0].data['text'],
      photo: data.documents[0].data['photo'],
      photoFile: underscorePhotoTmp,
    );
 */
    state = underscoreTmp;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${data.total.toString()} and The AnchkConductorNotifier state Lenght is ${state.length.toString()} and The AnchkConductorNotifier state name is ${state[0].name.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final anchkConductorNotifierProvider =
    StateNotifierProvider<AnchkConductorNotifier, List<Conductor>>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return AnchkConductorNotifier(apiServce);
});
