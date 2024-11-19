import 'package:flutter/material.dart';

import '../service/appwrite.dart';

class AppConstants {
  static const String version = '1.2.13';
//  static const deployment = DeploymentMode.production;
  static const deployment = DeploymentMode.uat;
//  static const deployment = DeploymentMode.development;

  static const String appTitle = '萬國宣道詠團';
  static const String appEmail = 'info@anchk.org';
  static const String logoPath = "assets/images/anchk-logo.PNG";
  static const String divider = "assets/images/divider-g8f3e8fda8_640.png";
  static const String anchkorgBanner = "assets/images/anchkorg-banner.png";

  static const bool debug = true;
  static const String project = "61b0428203f09";
  static const String devProject = "65fb853ee5016cf80852";
  static const String uatProject = "65f927ec2915c005d028";
//  static const String callback = "appwrite-callback-$project";
//  static const String host = "cloud.appwrite.io";
  static const String host = "appwrite.anchk.org";
  static const String devHost = "appwrite-dev.anchk.org";
  static const String uatHost = "appwrite.anchk.org";
//  static const String host = "backend-02.anchk.org";
//  static const String host = "backend.anchk.org";
  static const String endpoint = "https://$host/v1";
  static const String projectInfoCollectionID = "projectInfo";
  static const String bgImage = 'assets/images/blueBubbleBG.JPG';
  static const double goldenRatio = 1.1618;
  static const String networkImagePath =
      "https://$host/v1/storage/buckets/default/files/";
  // https://appwrite.anchk.org/v1/storage/buckets/default/files/65c6c97f7e51a7b5e6d3/view?project=61b0428203f09&mode=admin

//  static const String bgImage =
//      "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  static const String countryPath = '/home/country';
  static const String profilePath = '/profile';
  static const Color defaultTextColor = Colors.black;
  static Color defaultSubTextColor = Colors.grey.withOpacity(0.7);
  static const TextStyle desktopTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle mobileTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle mobileOutlineBtnTextStyle =
      TextStyle(color: Colors.black);
  static const TextStyle mobileDataTextStyle =
      TextStyle(fontSize: 45, fontWeight: FontWeight.bold);
  static const TextStyle mobileTitleTextStyle = TextStyle(fontSize: 30);
  static const TextStyle desktopOutlineBtnTextStyle =
      TextStyle(color: Colors.black);
  static const TextStyle desktopDataTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);
  static const TextStyle desktopTitleTextStyle = TextStyle(fontSize: 45);

  static const TextStyle mobileProfileDataTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const TextStyle desktopProfileDataTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);
}
