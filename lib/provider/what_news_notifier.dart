import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/what_news_model.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class WhatNewsNotifier extends StateNotifier<List<WhatNews>> {
  WhatNewsNotifier(this.apiServce, this.ref) : super([]);
  DebugLogger debugLogger = DebugLogger.instance;
  final Ref ref;
  final ApiService apiServce;
  final String className = "WhatNewsNotifier";
  final String databaseId = 'default';
  final String collectionId = '61b1cc5580c71';

  final List<String> queriesCompleted = [
    appwrite.Query.limit(50),
    appwrite.Query.equal('isCompleted', true),
    appwrite.Query.orderDesc('year'),
    appwrite.Query.orderDesc('month'),
    appwrite.Query.orderDesc('day'),
  ];
  final List<String> queriesNotCompleted = [
    appwrite.Query.limit(50),
    appwrite.Query.equal('isCompleted', false),
    appwrite.Query.orderAsc('year'),
    appwrite.Query.orderAsc('month'),
    appwrite.Query.orderAsc('day'),
  ];

  static bool? _isInitial = true;
  bool? get isInitial => _isInitial;
  static String? _progress;
  String? get progress => _progress;
  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void init() async {
    _progress = "0％";
    List<WhatNews> underscoreWhatNewsTmp = [];
    DocumentList? dataInitNotCompleted;
    final List<String> queriesInitNotCompleted = [
      appwrite.Query.limit(1),
      appwrite.Query.equal('isCompleted', false),
      appwrite.Query.orderAsc('year'),
      appwrite.Query.orderAsc('month'),
      appwrite.Query.orderAsc('day'),
    ];

    dataInitNotCompleted = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queriesInitNotCompleted,
    );

    for (var element in dataInitNotCompleted!.documents) {
      /** Uint8List underscoreBgPhoto = Uint8List(0);
      Uint8List underscorePhoto = Uint8List(0);
       int bgPhotoIdCheckIndex = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['bgPhotoId']);
      if (bgPhotoIdCheckIndex >= 0) {
        underscoreBgPhoto = appwriteFilePool![bgPhotoIdCheckIndex].file!;
      } else {
        await apiServce
            .getFile(element.data['bgPhotoId'])
            .then((bgPhotofile) async {
          underscoreBgPhoto = bgPhotofile;
          appwriteFilePool!.add(
              AppwriteFile(id: element.data['bgPhotoId'], file: bgPhotofile));
        });
      }
      
      int index = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['photoId']);
      
      if (index >= 0) {
        underscorePhoto = appwriteFilePool![index].file!;
      } else {
        await apiServce.getFile(element.data['photoId']).then((photoFile) {
          underscorePhoto = photoFile;
        });
      } */
      underscoreWhatNewsTmp.add(WhatNews.fromObject(
        map: element.data,
        //  bgPhotoFile: underscoreBgPhoto,
        //  photoFile: underscorePhoto,
      ));
//      state.add(WhatNews.fromObject(
//          map: element.data,
//          bgPhotoFile: underscoreBgPhoto,
//          photoFile: underscorePhoto));
    }
    debugLogger.debug(
      className: className,
      method: "initNotCompleted()",
      printToConsole: true,
      value:
          "The data Lenght is ${dataInitNotCompleted.total.toString()} and The WhatNewsNotifier state Lenght is ${state.length.toString()} and the loading is ${loading.toString()}",
    );

    DocumentList? dataInitCompleted;
    final List<String> queriesInitCompleted = [
      appwrite.Query.limit(1),
      appwrite.Query.equal('isCompleted', true),
      appwrite.Query.orderDesc('year'),
      appwrite.Query.orderDesc('month'),
      appwrite.Query.orderDesc('day'),
    ];

    dataInitCompleted = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queriesInitCompleted,
    );

    for (var element in dataInitCompleted!.documents) {
      /** Uint8List underscoreBgPhoto = Uint8List(0);
      Uint8List underscorePhoto = Uint8List(0);
      
      int bgPhotoIdCheckIndex = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['bgPhotoId']);
      if (bgPhotoIdCheckIndex >= 0) {
        underscoreBgPhoto = appwriteFilePool![bgPhotoIdCheckIndex].file!;
      } else {
        await apiServce
            .getFile(element.data['bgPhotoId'])
            .then((bgPhotofile) async {
          underscoreBgPhoto = bgPhotofile;
          appwriteFilePool!.add(
              AppwriteFile(id: element.data['bgPhotoId'], file: bgPhotofile));
        });
      }
      int index = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['photoId']);
      if (index >= 0) {
        underscorePhoto = appwriteFilePool![index].file!;
      } else {
        await apiServce.getFile(element.data['photoId']).then((photoFile) {
          underscorePhoto = photoFile;
        });
      }
       */
      underscoreWhatNewsTmp.add(WhatNews.fromObject(
        map: element.data,
        //    bgPhotoFile: underscoreBgPhoto,
        //    photoFile: underscorePhoto,
      ));
      state.add(WhatNews.fromObject(
        map: element.data,
        //    bgPhotoFile: underscoreBgPhoto,
        //    photoFile: underscorePhoto,
      ));
    }

    state = underscoreWhatNewsTmp;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "initCompleted()",
      printToConsole: true,
      value:
          "The data Lenght is ${dataInitCompleted.total.toString()} and The WhatNewsNotifier state Lenght is ${state.length.toString()} and the loading is ${loading.toString()}",
    );
  }

  void load() async {
    List<WhatNews> underscoreWhatNewsTmp = [];
    DocumentList? dataCompleted;
    DocumentList? dataNotCompleted;
    int? totalItems;

    dataNotCompleted = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queriesNotCompleted,
    );

    dataCompleted = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queriesCompleted,
    );
    totalItems = dataNotCompleted!.total + dataCompleted!.total;
    //state = [];

    for (var element in dataNotCompleted.documents) {
      /**  Uint8List underscoreBgPhoto = Uint8List(0);
      Uint8List underscorePhoto = Uint8List(0);
     
      int bgPhotoIdCheckIndex = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['bgPhotoId']);
      if (bgPhotoIdCheckIndex >= 0) {
        underscoreBgPhoto = appwriteFilePool![bgPhotoIdCheckIndex].file!;
      } else {
        await apiServce
            .getFile(element.data['bgPhotoId'])
            .then((bgPhotofile) async {
          underscoreBgPhoto = bgPhotofile;
          appwriteFilePool!.add(
              AppwriteFile(id: element.data['bgPhotoId'], file: bgPhotofile));
        });
      }
      int index = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['photoId']);
      if (index >= 0) {
        underscorePhoto = appwriteFilePool![index].file!;
      } else {
        await apiServce.getFile(element.data['photoId']).then((photoFile) {
          underscorePhoto = photoFile;
        });
      }
       */
      underscoreWhatNewsTmp.add(WhatNews.fromObject(
        map: element.data,
        //  bgPhotoFile: underscoreBgPhoto,
        //  photoFile: underscorePhoto,
      ));
      //state = underscoreWhatNewsTmp;
      /** 
        state.add(WhatNews.fromObject(
          map: element.data,
          bgPhotoFile: underscoreBgPhoto,
          photoFile: underscorePhoto));
     */
      _progress =
          "${((underscoreWhatNewsTmp.length - 1) / totalItems * 100).round()}％";
      ref.read(whatsNewProgressNotifierProvider.notifier).update(_progress!);
      debugLogger.debug(
        className: className,
        method: "load()",
        printToConsole: true,
        value:
            "The progress is ${progress.toString()} and underscoreWhatNewsTmp is ${underscoreWhatNewsTmp.length.toString()} on DataNotCompleted and state is ${state.length.toString()} on DataNotCompleted",
      );
    }

    for (var element in dataCompleted.documents) {
      /** Uint8List underscoreBgPhoto = Uint8List(0);
      Uint8List underscorePhoto = Uint8List(0);
      
      int bgPhotoIdCheckIndex = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['bgPhotoId']);
      if (bgPhotoIdCheckIndex >= 0) {
        underscoreBgPhoto = appwriteFilePool![bgPhotoIdCheckIndex].file!;
      } else {
        await apiServce
            .getFile(element.data['bgPhotoId'])
            .then((bgPhotofile) async {
          underscoreBgPhoto = bgPhotofile;
          appwriteFilePool!.add(
              AppwriteFile(id: element.data['bgPhotoId'], file: bgPhotofile));
        });
      }
      int index = appwriteFilePool!
          .indexWhere((checkId) => checkId.id == element.data['photoId']);
      if (index >= 0) {
        underscorePhoto = appwriteFilePool![index].file!;
      } else {
        await apiServce.getFile(element.data['photoId']).then((photoFile) {
          underscorePhoto = photoFile;
        });
      }
       */
      underscoreWhatNewsTmp.add(WhatNews.fromObject(
        map: element.data,
        //  bgPhotoFile: underscoreBgPhoto,
        //  photoFile: underscorePhoto,
      ));
      //state = underscoreWhatNewsTmp;
      /** state.add(WhatNews.fromObject(
          map: element.data,
          bgPhotoFile: underscoreBgPhoto,
          photoFile: underscorePhoto)); */
      _progress =
          "${((underscoreWhatNewsTmp.length - 1) / totalItems * 100).round()}％";
      ref.read(whatsNewProgressNotifierProvider.notifier).update(_progress!);
      debugLogger.debug(
        className: className,
        method: "load()",
        printToConsole: true,
        value:
            "The progress is ${progress.toString()} and underscoreWhatNewsTmp is ${underscoreWhatNewsTmp.length.toString()} on DataCompleted and state is ${state.length.toString()} on DataCompleted",
      );
    }
    state = underscoreWhatNewsTmp;
    _isInitial = false;

    _loading = false;
    debugLogger.debug(
      className: className,
      method: "load()",
      printToConsole: AppConstants.debug,
      value:
          "The data Lenght is ${dataCompleted.total.toString()} and The WhatNewsNotifier state Lenght is ${state.length.toString()} and the loading is ${loading.toString()}",
    );
  }
}

final whatNewsNotifierProvider =
    StateNotifierProvider<WhatNewsNotifier, List<WhatNews>>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return WhatNewsNotifier(apiServce, ref);
});

class WhatsNewProgressNotifier extends StateNotifier<String> {
  WhatsNewProgressNotifier() : super("");
  Future<String> update(String value) async {
    state = value;
    return state;
  }
}

final whatsNewProgressNotifierProvider =
    StateNotifierProvider<WhatsNewProgressNotifier, String>((ref) {
  return WhatsNewProgressNotifier();
});
