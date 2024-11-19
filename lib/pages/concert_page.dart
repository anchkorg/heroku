import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../entity/youtube_model.dart';
import '../provider/anchk_concert_notifier.dart';
import '../provider/anchk_video_notifier.dart';
//import '../provider/current_menu_notifer.dart';
import '../service/debug_logger.dart';
import '../shared/custom_box_decoration.dart';
//import '../shared/custom_navigator.dart';
import '../shared/custom_text.dart';
//import '../shared/route.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';

class ConcertPage extends ConsumerStatefulWidget {
  ConcertPage({super.key});
  final DebugLogger debugLogger = DebugLogger.instance;
  final String className = "ConcertPage";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConcertPageState();
}

class _ConcertPageState extends ConsumerState<ConcertPage> {
  late List<dynamic> _youtubeId = [];
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
    final concertItemState = ref.watch(anchkConcertNotifierProvider);

    final List<YoutubeModel> state = ref.watch(anchkVideoNotifierProvider);
    _youtubeId = state.map((element) => element.youtubeId).toList();
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        decoration: customTextBoxDecoration(),
                        child: const CustomAnnouncementTextBox(
                            text: '音樂會順利完成，多謝你們光臨。')),
                    _space,
                    videoTitleWidget,
                    videoPlayerWidget,
                    const SizedBox(
                      height: 8,
                    ),
                    _space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: concertItemState.name!,
                        textAlign: TextAlign.center,
                        size: 24.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    _space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: concertItemState.message!,
                        textAlign: TextAlign.center,
                        size: 24.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    _space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: concertItemState.location!,
                        textAlign: TextAlign.center,
                        size: 24.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    _space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: concertItemState.date!,
                        textAlign: TextAlign.center,
                        size: 24.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    _space,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: concertItemState.time!,
                        textAlign: TextAlign.center,
                        size: 24.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                    _space,
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.memory(
                          concertItemState.photoFile as Uint8List,
                          fit: BoxFit.cover,
                        )
                        //Image.asset("assets/images/anchk-concert.jpg"),
                        ),
                    _space,
                    /**
                    Container(
                      width: double.infinity,
                      decoration: customTextBoxDecoration(),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(currentMenuStateProvider.notifier).update(9);
                          ref.read(activeItem.notifier).state =
                              contactPageDisplayName;
                          ref
                              .read(navigatorKeyStateProvider)
                              .currentState!
                              .pushNamed(sideMenuItemRoutes[9].route);
                        },
                        child: const CustomAnnouncementTextBox(
                            text: '歡迎大家參加我們的音樂會，如需要購買門票，請聯絡我們。'),
                      ),
                    ),
 */
                  ],
                ),
              ),
            ),
          );
  }
}

class CustomAnnouncementTextBox extends StatelessWidget {
  const CustomAnnouncementTextBox({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomText(
        text: text,
        textAlign: TextAlign.center,
        size: 24.0,
        weight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class ShadowText extends StatelessWidget {
  const ShadowText({
    super.key,
    required this.text,
    this.size = 14,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.shadow = const [],
    this.softWrap = true,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final List<Shadow> shadow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 1.0,
            left: 1.0,
            child: CustomText(
              text: text,
              size: size,
              color: color.withOpacity(0.5),
              weight: weight,
              textAlign: textAlign,
              textDecoration: textDecoration,
              shadow: shadow,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: CustomText(
              text: text,
              color: color,
              size: size,
              weight: weight,
              textAlign: textAlign,
              textDecoration: textDecoration,
              shadow: shadow,
            ),
          ),
        ],
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
