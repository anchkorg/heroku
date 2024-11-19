import '../shared/app_constants.dart';
import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/concert.dart';
import '../entity/appwrite_file.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class AnchkConcertNotifier extends StateNotifier<Concert> {
  AnchkConcertNotifier(this.apiServce) : super(Concert(name: "Initial"));
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "AnchkConcertNotifier";
  final String databaseId = 'default';
  final String collectionId = 'concert';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    Concert underscoreTmp = Concert(name: "Introduction");
    Uint8List underscorePhotoTmp = Uint8List(0);
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
    if (state.photo == data!.documents[0].data['photo']) {
      underscorePhotoTmp = state.photoFile!;
    } else {
      await apiServce
          .getFile(data.documents[0].data['photo'])
          .then((photofile) async {
        underscorePhotoTmp = photofile;
      });
    }
    underscoreTmp = Concert(
      name: data.documents[0].data['name'],
      message: data.documents[0].data['message'],
      photo: data.documents[0].data['photo'],
      location: data.documents[0].data['location'],
      date: data.documents[0].data['date'],
      time: data.documents[0].data['time'],
      photoFile: underscorePhotoTmp,
    );

    state = underscoreTmp;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${data.total.toString()} and The AnchkConcertNotifier state name is ${state.name.toString()} and The AnchkConcertNotifier state name is ${state.message.toString()} and The AnchkConcertNotifier state name is ${state.location.toString()} and The AnchkConcertNotifier state name is ${state.date.toString()} and The AnchkConcertNotifier state name is ${state.time.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final anchkConcertNotifierProvider =
    StateNotifierProvider<AnchkConcertNotifier, Concert>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return AnchkConcertNotifier(apiServce);
});
