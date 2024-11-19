import '../service/appwrite.dart';
//import '../shared/app_constants.dart';

class YoutubeModel {
  final int id;
  final String youtubeId;
  final String youtubeTitle;
  final String thumbnailImage;

  const YoutubeModel({
    required this.youtubeTitle,
    required this.id,
    required this.youtubeId,
    required this.thumbnailImage,
  });
  factory YoutubeModel.fromMap(Map<String, dynamic> map) {
    var appwrite = ApiService.instance;
    return YoutubeModel(
      youtubeId: map['youtubeId'],
      id: map['id'],
      youtubeTitle: map['youtubeTitle'],
      thumbnailImage:
          "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${map['thumbnailImage']}/view?project=${appwrite.getProject()}&mode=admin",
    );
  }
  @override
  String toString() {
    return 'YoutubeModel\nyoutubeId: $youtubeId\nyoutubeTitle: $youtubeTitle';
  }
}
