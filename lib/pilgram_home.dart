import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../CustomElevatedButton.dart';
import '../styles.dart';

class PilgramHomePage extends StatelessWidget {
  const PilgramHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildChoice(
                context,
                'images/ritual.png',
                AppLocalizations.of(context)!.hajjRitual,
              ),
              _buildChoice(
                context,
                'images/p12.png',
                AppLocalizations.of(context)!.healthInstructions,
              ),
              _buildChoice(
                context,
                'images/healh.png',
                AppLocalizations.of(context)!.healthVituls,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoice(
    BuildContext context,
    String imagePath,
    String buttonText,
  ) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 90.0,
            width: 290.0,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset(imagePath),
            ),
          ),
          CustomElevatedButton(
            onPressed: () {},
            child: Text(
              buttonText,
              style: ThemeText.buttonText2,
            ),
            verticalPorder: 5.0,
          ),
        ],
      ),
    );
  }
}
