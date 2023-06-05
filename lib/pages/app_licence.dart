import 'package:flutter/material.dart';

class AppLicencePage extends StatelessWidget {
  const AppLicencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Image.asset("assets/logo.png",height: 78,width: 78,),
      ),
      applicationName: "Live EMF Detector",
      applicationLegalese: "",
      applicationVersion: "1.0.0+3",
    );
  }
}
