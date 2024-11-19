import 'package:concert/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/application_page.dart';
import '../pages/auth_page.dart';
import '../pages/concert_page.dart';
import '../pages/contact_page.dart';
import '../pages/debugger_page.dart';
import '../pages/history_page.dart';
import '../pages/introduction_page.dart';
import '../pages/leader_page.dart';
import '../pages/practice_page.dart';
import '../pages/profile_page.dart';
import '../pages/requirement_page.dart';
import '../pages/what_news_page.dart';
import 'app_constants.dart';
import 'style.dart';

const counterPageRoute = "/counterPage";
const counterPageDisplayName = "CounterPage";
const concertPageRoute = "/concertPage";
const concertPageDisplayName = "音樂會";
const appwritePageRoute = "/appwritePage";
const appwritePageDisplayName = "AppwritePage";
const splashPageDisplayName = AppConstants.appTitle;
const splashPageRoute = "/splash";
const whatNewsPageDisplayName = "最新消息";
const whatNewsPageRoute = "/whatnews";
const introductionPageDisplayName = "詠團組織";
const introductionPageRoute = "/introduction";
const missionPageDisplayName = "詠團宗旨";
const missionPageRoute = "/mission";
const conductorPageDisplayName = "詠團指揮";
const conductorPageRoute = "/conductor";
const preachersPageDisplayName = "詠團團牧";
const preachersPageRoute = "/preachers";
const leadersPageDisplayName = "團牧/指揮";
const leadersPageRoute = "/leaders";
const historyPageDisplayName = "歷年事工";
const historyPageRoute = "/history";
const videoPageDisplayName = "詠團影片";
const videoPageRoute = "/video";
const practicePageDisplayName = "詠團練習";
const practicePageRoute = "/practice";
const requirementPageDisplayName = "申請者條件";
const requirementPageRoute = "/requirement";
const applicationtPageDisplayName = "團員申請";
const applicationPageRoute = "/application";
const contactPageDisplayName = "聯絡";
const contactPageRoute = "/contact";
const authPageDisplayName = "登入";
const authPageRoute = "/auth";
const profilePageDisplayName = "帳戶";
const profilePageRoute = "/profile";
const debugLoggerPageDisplayName = "帳戶";
const debugLoggerPageRoute = "/debugger";
const defaultPageRoute = whatNewsPageRoute;
const defaultPageDisplayName = whatNewsPageDisplayName;

class CustomMenuItem {
  final String name;
  final String route;

  CustomMenuItem(this.name, this.route);
}

List<CustomMenuItem> sideMenuItemRoutes = [
  CustomMenuItem(whatNewsPageDisplayName, whatNewsPageRoute),
//  CustomMenuItem(concertPageDisplayName, concertPageRoute),
  CustomMenuItem(introductionPageDisplayName, introductionPageRoute),
  CustomMenuItem(leadersPageDisplayName, leadersPageRoute),
  CustomMenuItem(historyPageDisplayName, historyPageRoute),
  CustomMenuItem(videoPageDisplayName, videoPageRoute),
  CustomMenuItem(practicePageDisplayName, practicePageRoute),
  CustomMenuItem(requirementPageDisplayName, requirementPageRoute),
  CustomMenuItem(applicationtPageDisplayName, applicationPageRoute),
  CustomMenuItem(contactPageDisplayName, contactPageRoute),
//  CustomMenuItem(authPageDisplayName, authPageRoute),
//  CustomMenuItem(counterPageDisplayName, counterPageRoute),
//  CustomMenuItem(appwritePageDisplayName, appwritePageRoute),
];

List<CustomMenuItem> appbarItemRoutes = [
  CustomMenuItem(debugLoggerPageDisplayName, debugLoggerPageRoute),
  CustomMenuItem(authPageDisplayName, authPageRoute),
  CustomMenuItem(profilePageDisplayName, profilePageRoute),
];

List<CustomMenuItem> allItemsRoutes = List.from(sideMenuItemRoutes)
  ..addAll(appbarItemRoutes);

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case concertPageRoute:
      return _getPageRoute(ConcertPage());
    case whatNewsPageRoute:
      return _getPageRoute(const WhatNewsPage());
    case introductionPageRoute:
      return _getPageRoute(const IntroductionPage());
    case leadersPageRoute:
      return _getPageRoute(const LeadersPage());
    case historyPageRoute:
      return _getPageRoute(const HistoryPage());
    case videoPageRoute:
      return _getPageRoute(VideoPage());
    case practicePageRoute:
      return _getPageRoute(const PracticePage());
    case requirementPageRoute:
      return _getPageRoute(const RequirementPage());
    case applicationPageRoute:
      return _getPageRoute(ApplicationPage());
    case contactPageRoute:
      return _getPageRoute(const ContactPage());
    case authPageRoute:
      return _getPageRoute(const AuthPage());
    case profilePageRoute:
      return _getPageRoute(const ProfilePage());
    case debugLoggerPageRoute:
      return _getPageRoute(const DebugLoggerPage());
//    case appwritePageRoute:
//      return _getPageRoute(const AppwritePage());
    default:
      return _getPageRoute(const WhatNewsPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

Widget returnIconFor(String itemName) {
  switch (itemName) {
    case concertPageDisplayName:
      return CustomIcon(Icons.music_note, itemName);
    case whatNewsPageDisplayName:
      return CustomIcon(Icons.info, itemName);
    case introductionPageDisplayName:
      return CustomIcon(Icons.call_made, itemName);
    case missionPageDisplayName:
      return CustomIcon(Icons.check_box_sharp, itemName);
    case leadersPageDisplayName:
      return CustomIcon(Icons.leaderboard, itemName);
    case conductorPageDisplayName:
      return CustomIcon(Icons.drive_eta, itemName);
    case preachersPageDisplayName:
      return CustomIcon(Icons.people_alt_outlined, itemName);
    case historyPageDisplayName:
      return CustomIcon(Icons.history, itemName);
    case videoPageDisplayName:
      return CustomIcon(Icons.video_collection, itemName);
    case practicePageDisplayName:
      return CustomIcon(Icons.list, itemName);
    case requirementPageDisplayName:
      return CustomIcon(Icons.notifications, itemName);
    case applicationtPageDisplayName:
      return CustomIcon(Icons.run_circle, itemName);
    case contactPageDisplayName:
      return CustomIcon(Icons.add_business, itemName);
    case appwritePageDisplayName:
      return CustomIcon(Icons.add_business, itemName);
    case authPageDisplayName:
      return CustomIcon(Icons.people, itemName);
    case debugLoggerPageDisplayName:
      return CustomIcon(Icons.bug_report, itemName);
    case counterPageDisplayName:
      return CustomIcon(Icons.exit_to_app, itemName);
    default:
      return CustomIcon(Icons.exit_to_app, itemName);
  }
}

final activeItem = StateProvider<String>((ref) {
  return defaultPageDisplayName;
});

class CustomIcon extends ConsumerWidget {
  const CustomIcon(this.icon, this.itemName, {super.key});
  final String itemName;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      icon,
      size: ref.read(activeItem) == itemName ? 30 : 22,
      color: ref.read(activeItem) == itemName ? menuActiveColor : menuColor,
    );
  }
}
