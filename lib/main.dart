import 'package:evently/ui/provider/language_provider.dart';
import 'package:evently/ui/provider/theme_provider.dart';
import 'package:evently/ui/screens/login/login.dart';
import 'package:evently/ui/screens/regester/regester.dart';
import 'package:evently/ui/screens/splash/splash.dart';
import 'package:evently/ui/utiliti/app_theem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //* this til to flutter before create the app initilaze some thing
  await Firebase.initializeApp(
    //*to initalize app in firebase
    options: DefaultFirebaseOptions.currentPlatform,
  ); //* this to import file (DefaultFirebaseOptions)
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), //* this provider control of themes
      child: ChangeNotifierProvider(
        //* this to the language provider (we ca replace there by multiprovider)
        create: (context) => LanguageProvider(),
        //! this is a function giv context and retuen tamplate but hav constrain (must create changeNotifire (يبلغ notification )  )
        //! hea we create one obgect and all classes see it
        child: const MyApp(),
      ),
    ),
  );
}

late LanguageProvider
languageProvider; //! this to change the language from login to main
late ThemeProvider themeProvider; //* this to change the theme mode

//* in apov line we have problem becuse the =>(LanguageProvider()) this create isolate obgect thay dont activ with same obgect
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(
      context,
    ); //! this to acsess in the curent language
    themeProvider = Provider.of(context);
    return MaterialApp(
      theme:
          AppTheem.lightTheme, //! this is a constant value to all thext in app
      darkTheme: AppTheem.darkTheme,
      themeMode: themeProvider.mode, //* to change the curent mode
      locale: Locale(
        languageProvider.curentLanguage,
      ), //! we have a proplem mus change the language by click on the togel:we create class carry the language
      localizationsDelegates: [
        //* this to miror the language
        AppLocalizations.delegate, // Add this line

        GlobalMaterialLocalizations.delegate, //* to the defult material
        GlobalWidgetsLocalizations.delegate, //* to the widget
        GlobalCupertinoLocalizations.delegate, //* this to ios
      ],
      supportedLocales: [
        //* tomimprome the en and ar
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      home: Login(), //* the inetial route
    );
  }
}
