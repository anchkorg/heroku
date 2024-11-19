import '../shared/app_constants.dart';
//import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart' as appwrite;

import '../entity/appwrite_file.dart';
import '../entity/contact_info.dart';
import '../entity/organization_info_model.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import 'appwrite_notifier.dart';

class ContactNotifier extends StateNotifier<ContactInfo> {
  ContactNotifier(this.apiServce) : super(ContactInfo());
  DebugLogger debugLogger = DebugLogger.instance;
  final ApiService apiServce;
  final String className = "ContactNotifier";
  final String databaseId = 'default';
  final String collectionId = 'contactList';
  final List<String> queries = [appwrite.Query.limit(100)];

  static bool? _loading = true;
  bool? get loading => _loading;
  List<AppwriteFile>? appwriteFilePool = [];

  void load() async {
    ContactInfo underscoreTmp = ContactInfo();
//    Uint8List underscorePhotoTmp = Uint8List(0);
    DocumentList? data;

    data = await apiServce.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );

    await apiServce.getPhoto("contactList").then((value) async {
      /**
      if (state.photo == value['fileId']) {
        underscorePhotoTmp = state.photoFile!;
      } else {
        await apiServce.getFile(value['fileId']).then((photofile) async {
          underscorePhotoTmp = photofile;
        });
      }
       */

      underscoreTmp = ContactInfo(
        organizationInfo: data!.convertTo<OrganizationInfo>(
            (p0) => OrganizationInfo.fromMap((Map<String, dynamic>.from(p0)))),
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

final contactNotifierProvider =
    StateNotifierProvider<ContactNotifier, ContactInfo>((ref) {
  final apiServce = ref.watch(appwriteNotifierProvider);
  return ContactNotifier(apiServce);
});
