import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:safe_hajj_app/styles.dart';
import 'CustomElevatedButton.dart';
import 'login.dart';
import 'paramedic/notification_service.dart';
import 'pilgram/pilgram_home.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //await NotificationService().init(); //
  // await NotificationService()
  //   . //

  // await NotificationService().requestPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safe Hajj",
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
      supportedLocales: [
        const Locale('ar'), // arabic
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // Set your desired style for AppBar here
          // For example, you can set the background color and text color

          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //NotificationService().showNotification();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logo(context),
                _header(context),
                _choicesButton(context),
              ],
            ),
          ),
        ));
  }

  _logo(context) {
    return Column(
      children: [
        Container(
          height: 250.0,
          width: 310.0,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Image.asset('images/logo.png'),
          ),
        ),
      ],
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.helloWorld1,
          style: GoogleFonts.aclonica(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.helloWorld2,
          style: ThemeText.headline2,
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.accountType,
          style: ThemeText.headline2,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  _choicesButton(context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 60,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PilgramHomePage()));
              },
              child: Text(
                AppLocalizations.of(context)!.pilgram,
                style: ThemeText.buttonText,
              ),
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                AppLocalizations.of(context)!.paramedic,
                style: ThemeText.buttonText,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
