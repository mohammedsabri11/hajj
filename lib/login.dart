import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'paramedic/Paramedic.dart';
import 'styles.dart';



class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});
  @override

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _logo(context),
              _header(context),
              _inputField(context),
              _forgotPassword(context),
            ],
          ),
        ),
      ),
    );
  }

  _logo(context) {
    return Column(
      children: [
        Container(
          height: 200.0,
          width: 290.0,
          padding: const EdgeInsets.only(top: 20),
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
          AppLocalizations.of(context)!.login,
          style: ThemeText.headline3,
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            height: 57,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.email,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.green.withOpacity(0.1),
                      filled: true,
                      hintTextDirection: TextDirection.rtl,
                      prefixIcon: const Icon(Icons.email)),
                ))),
        const SizedBox(height: 5),
        Container(
            height: 57,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Colors.green.withOpacity(0.1),
                    filled: true,
                    hintTextDirection: TextDirection.rtl,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  obscureText: true,
                ))),
        const SizedBox(height: 10),
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

               //login(context, email, password);
                Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => const ParamedicHomePage()));
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.green,
              ),
              child: Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(fontSize: 18),
              ),
            ))
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        AppLocalizations.of(context)!.forgetPassword,
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  Future<void> login(context, String email, String password) async {
    showLoaderDialog(context); //10.0.2.2
    final url = Uri.parse('http://172.19.16.47:8000/paramedic/login/' +
        email +
        '/' +
        password +
        '/');
    try {
      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        // Successful login
        final Map data = json.decode(response.body);
        //Map<String, dynamic> data = jsonDecode(response.body);
        //_showErrorDialog(context, data["msg"], response.body);
        //print(data);
        if (data["status"] == true)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ParamedicHomePage()));
        else
          _showErrorDialog(context, "خطا ", data["msg"]);
        //Navigator.pop(context);
        // print('Login successful');
        //print(response.body);
      } else {
        // Failed login
        //  print('Login failed');
        //if (!context.) return;

        _showErrorDialog(
            context, 'خطا في تسجيل الدخول', "لايوجد اتصال بالسيرفر");
        //print(response.body);
      }
    } catch (e) {
      _showErrorDialog(context, 'فشلت العملية', e.toString());
    }
  }

  _showErrorDialog(context, String title, String message) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (ctx) => PlaceholderDialog(
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 80.0,
        ),
        title: title,
        message: message,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('حاول مرة خرى '),
          ),
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(right: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

/* Future<void> saveLoginDetails(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setString('password', password);
} */

class PlaceholderDialog extends StatelessWidget {
  const PlaceholderDialog({
    this.icon,
    this.title,
    this.message,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final String? message;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: icon,
      title: title == null
          ? null
          : Text(
              title!,
              textAlign: TextAlign.center,
            ),
      titleTextStyle: ThemeText.headline5,
      content: message == null
          ? null
          : Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(
                message!,
                textAlign: TextAlign.center,
              )),
      contentTextStyle: ThemeText.textBody,
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
      actions: actions,
    );
  }
}
