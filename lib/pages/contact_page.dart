//import 'package:concert/shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../provider/contact_info_notifier.dart';
import '../service/appwrite.dart';
import '../service/debug_logger.dart';
import '../shared/custom_text.dart';
import '../shared/responsiveness.dart';
import '../shared/splash_widget.dart';
import '../shared/style.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});
  static DebugLogger debugLogger = DebugLogger.instance;
  final String className = "ContactPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactNotifierProvider);
    List<Widget> items = [];
    var appwrite = ApiService.instance;

    for (final item in state.organizationInfo!.toList()) {
      items.add(_contactInfo(item));
    }
    return (state.photo!.isEmpty)
        ? const SplashWidget()
        : LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 485
                                            : 588,
                                    height:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 314
                                            : 400,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.network(
                                              "https://${appwrite.getHost()}/v1/storage/buckets/default/files/${state.photo}/view?project=${appwrite.getProject()}&mode=admin",
                                              fit: BoxFit.cover,
                                            ),
                                            //Image.memory(
                                            //  state.photoFile!,
                                            //  fit: BoxFit.cover,
                                            //),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          ResponsiveWidget.isiPadScreen(context)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: items,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: items,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

Widget _contactInfo(dynamic item) => Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectionArea(
                  child: CustomText(
                    text: item.name.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.phone, size: 22, color: dark),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (await canLaunchUrlString(
                        'tel:${item.telephone.toString()}')) {
                      await launchUrlString('tel:${item.telephone.toString()}');
                    } else {
                      throw 'Could not launch ${item.email.toString()}';
                    }
                  },
                  child: CustomText(
                    text: item.telephone.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.web, size: 22, color: dark),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (await canLaunchUrlString(item.url.toString())) {
                      await launchUrlString(
                        item.url.toString(),
                      );
                    } else {
                      throw 'Could not launch ${item.url.toString()}';
                    }
                  },
                  child: CustomText(
                    text: item.url.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.email_outlined, size: 22, color: dark),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (await canLaunchUrlString(
                        'mailto:${item.email.toString()}')) {
                      await launchUrlString(
                          'mailto:${item.email.toString()}?subject=關於萬國宣道詠團的查詢');
                    } else {
                      throw 'Could not launch ${item.email.toString()}';
                    }
                  },
                  child: CustomText(
                    text: item.email.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.facebook, size: 22, color: dark),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (await canLaunchUrlString(item.facebook.toString())) {
                      await launchUrlString(
                        item.facebook.toString(),
                        //forceSafariVC: true,
                        //forceWebView: true,
                      );
                    } else {
                      throw 'Could not launch ${item.facebook.toString()}';
                    }
                  },
                  child: CustomText(
                    text: item.name.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
          (item.whatsapp.isNotEmpty)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.whatshot, size: 22, color: dark),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final link = WhatsAppUnilink(
                            phoneNumber: item.whatsapp.toString(),
                            text: item.whatsappGreeting.toString(),
                          );
                          if (await canLaunchUrlString(
                              link.asUri().toString())) {
                            await launchUrlString(link.asUri().toString());
                          } else {
                            throw 'Could not launch ${link.asUri().toString()}';
                          }
                        },
                        child: CustomText(
                          text: "歡迎 WhatsApp 我們",
                          size: standardTextSize,
                          weight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
