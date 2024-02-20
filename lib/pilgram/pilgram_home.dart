import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../CustomElevatedButton.dart';
import '../styles.dart';
import 'hajj_ritual.dart';
import 'list_data_model.dart';
import 'pilgram_vituals.dart';

class PilgramHomePage extends StatelessWidget {
  const PilgramHomePage({super.key});

  void navigateToHajjRitual(context) {
    List<ListDatalModel> ritualList = Model.getRitualList(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HajjRitualListPage(ritualList)));
  }

  void navigateToHealtyHabits(context) {
    List<ListDatalModel> healtyHabitList = Model.getHealthHabitsList(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HajjRitualListPage(healtyHabitList)));
  }

  void navigateToHealthVituls(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HealthVitulsPage()));
  }

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
                  () => navigateToHajjRitual(context)),
              _buildChoice(
                  context,
                  'images/p12.png',
                  AppLocalizations.of(context)!.healthInstructions,
                  () => navigateToHealtyHabits(context)),
              _buildChoice(
                  context,
                  'images/healh.png',
                  AppLocalizations.of(context)!.healthVituls,
                  () => navigateToHealthVituls(context)),
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
    VoidCallback onPress,
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
            onPressed: onPress,
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
