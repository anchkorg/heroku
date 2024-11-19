import '../shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../entity/youtube_model.dart';
import '../provider/anchk_video_notifier.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class VideoPage extends ConsumerStatefulWidget {
  VideoPage({super.key});
  final DebugLogger debugLogger = DebugLogger.instance;
  final String className = "VideoPage";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late List<dynamic> _youtubeId = [];
  late List<dynamic> _youtubeImage = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _youtubeId = [
      'Hp8P_CXOQ68',
      'b53oI2p-UrI',
      'ArJj0pMqJls',
      'UXP9sR0A0vQ',
      'C2szYJuQymI',
      'CkjbpbRrRYo',
      'gCwHitVRirI',
      '7pc4rNCmEqo',
    ];
    _youtubeImage = [
      'https://appwrite.anchk.org/v1/storage/files/61fa03501566e7c7e9f5/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa03b010bb5b1a9e37/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa0413da27c99de0e2/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa044fabb08c9ad763/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa049502e56e485502/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa04d454a878685a54/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa05204108db2edb40/view?project=61b0428203f09&mode=admin',
      'https://appwrite.anchk.org/v1/storage/files/61fa0587498cdb051b57/view?project=61b0428203f09&mode=admin',
    ];
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            // show the back-to-top button
          } else {
            // hide the back-to-top button
          }
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    ref.listenManual(anchkVideoNotifierProvider, (previous, next) {});
  }

  @override
  Widget build(BuildContext context) {
    // "ref" is not passed as parameter anymore, but is instead a property of "ConsumerState".
    // We can therefore keep using "ref.watch" inside "build".
    int current = 0;
    final List<YoutubeModel> state = ref.watch(anchkVideoNotifierProvider);
    List<dynamic> underscoreYoutubeTitle = [];
    _youtubeId = state.map((element) => element.youtubeId).toList();
    _youtubeImage = state.map((element) => element.thumbnailImage).toList();
    underscoreYoutubeTitle =
        state.map((element) => element.youtubeTitle).toList();
    final List<YoutubePlayerController> underscoreControllers = _youtubeId
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController.fromVideoId(
            videoId: videoId,
            params: const YoutubePlayerParams(
              showFullscreenButton: true,
            ),
          ),
        )
        .toList();

    void underscoreScrollToTop() {
      _scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }

    updateCurrent(int value) {
      setState(() {
        current = value;
        ref.read(anchkVideoNotifierProvider.notifier).updateCurrentVideo(value);
        widget.debugLogger.debug(
          className: widget.className,
          method: "updateCurrent(${value.toString()})",
          printToConsole: AppConstants.debug,
          value: "current is $current",
        );
        underscoreScrollToTop();
      });
    }

    Widget listVideoWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _youtubeId
          .map(
            (e) => _youtubeId.indexOf(e) !=
                    ref
                        .read(anchkVideoNotifierProvider.notifier)
                        .currentVideoIndex
                ? InkWell(
                    onTap: () => updateCurrent(_youtubeId.indexOf(e)),
                    child: VideoCard(
                        e: e,
                        youtubeTitle: underscoreYoutubeTitle,
                        youtubeId: _youtubeId,
                        // screenWidth: screenWidth,
                        youtubeImage: _youtubeImage),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
          )
          .toList(),
    );
    Widget videoPlayerWidget = Column(
      children: underscoreControllers
          .map((e) => underscoreControllers.indexOf(e) ==
                  ref
                      .read(anchkVideoNotifierProvider.notifier)
                      .currentVideoIndex
              ? YoutubePlayer(
                  key: ObjectKey(e),
                  aspectRatio: 16 / 9,
                  controller: e,
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ))
          .toList(),
    );
    Widget videoTitleWidget = Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
      child: CustomText(
        text: state[ref
                .read(anchkVideoNotifierProvider.notifier)
                .currentVideoIndex!
                .toInt()]
            .youtubeTitle,
        textAlign: TextAlign.center,
      ),
    );
    return (state.isEmpty)
        ? const SplashWidget()
        : Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    videoTitleWidget,
                    videoPlayerWidget,
                    const SizedBox(
                      height: 8,
                    ),
                    listVideoWidget,
                  ],
                ),
              ),
            ),
          );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required dynamic e,
    required List youtubeTitle,
    required List youtubeId,
//    required this.screenWidth,
    required List youtubeImage,
  })  : _e = e,
        underscoreYoutubeTitle = youtubeTitle,
        _youtubeId = youtubeId,
        _youtubeImage = youtubeImage;

  final dynamic _e;
  final List underscoreYoutubeTitle;
  final List _youtubeId;
  final List _youtubeImage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: underscoreYoutubeTitle[_youtubeId.indexOf(_e)],
                size: standardTextSize,
                color: blackColor,
                weight: FontWeight.bold,
              ),
              _space,
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF696969),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(_youtubeImage[_youtubeId.indexOf(_e)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget get _space => const SizedBox(height: 10);
