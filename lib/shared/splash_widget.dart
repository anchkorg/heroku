import 'package:flutter/material.dart';

import '../service/appwrite.dart';
//import 'app_constants.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appwrite = ApiService.instance;

    return Center(
      child: SizedBox(
        width: 350,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 10),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://${appwrite.getHost()}/v1/storage/buckets/default/files/slogon/view?project=${appwrite.getProject()}&mode=admin"),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
