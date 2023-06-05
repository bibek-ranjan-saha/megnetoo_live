import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/app_data.dart';
import '../pages/app_licence.dart';

class AboutMeDialog extends StatefulWidget {
  const AboutMeDialog({Key? key}) : super(key: key);

  @override
  State<AboutMeDialog> createState() => _AboutDialogState();
}

class _AboutDialogState extends State<AboutMeDialog> {
  Future<List<AppData>> getApps() async {
    http.Response response = await http.get(
        Uri.parse("https://bibek-ranjan-saha.github.io/apps_list/index.json"));
    return appDataFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      title: const Text(
        "About me",
        style: TextStyle(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Bibek Ranjan Saha",
            style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset("assets/bibek.jpg")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 80,
              width: size.width - 60,
              child: FutureBuilder<List<AppData>>(
                  future: getApps(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Row(
                          children: [
                            CircularProgressIndicator(
                                color: Colors.deepOrangeAccent),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Loading my projects"),
                            )
                          ],
                        );
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasError) {
                          return GestureDetector(
                            onTap: () {},
                            child: const Row(
                              children: [
                                Icon(Icons.running_with_errors),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("No Internet"),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Center(
                                child: ListTile(
                                  tileColor: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: SizedBox(
                                      height: 42,
                                      width: 42,
                                      child: Image.network(
                                        "${snapshot.data?[index].appLogo}",
                                        errorBuilder: (ctx, obj, stacktrace) {
                                          return const Icon(Icons
                                              .image_not_supported_outlined);
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text("${snapshot.data?[index].title}"),
                                  subtitle: Text(
                                      "${snapshot.data?[index].description}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await launchUrl(Uri.parse(
                                          "${snapshot.data?[index].link}"));
                                    },
                                    icon: const Icon(Icons.download_outlined),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                    }
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await launchUrl(Uri.parse("https://bibek-saha.web.app/"),
                  mode: LaunchMode.externalApplication);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(size.width, 50),
                enableFeedback: true,
                backgroundColor: Colors.lightGreenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text(
              "Visit Portfolio",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const AppLicencePage()));
              },
              child: const Text("View Licences"),
            ),
          ),
        ],
      ),
    );
  }
}
