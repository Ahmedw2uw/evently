import 'package:evently/ui/custom_widgets/custom_buttom.dart';
import 'package:evently/ui/custom_widgets/custom_text_feild.dart';
import 'package:evently/ui/provider/language_provider.dart';
import 'package:evently/ui/provider/theme_provider.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:evently/ui/utiliti/app_routes.dart';
import 'package:evently/ui/utiliti/dialog_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart'; //Toggel

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController =
      TextEditingController(); //* there to control the login way
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(
      context,
      listen: true, //* this is assin to this page is lisner to the notyfylisner
    ); //! to taik the curent language to potin as a same opgect
    themeProvider = Provider.of(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          //* to can scrol
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24),
              bildAppLogo(),
              SizedBox(height: 24),

              bildEmailTextFeald(),
              SizedBox(height: 16),
              bildPaswordTextFeald(),

              bildForgetPassword(),
              SizedBox(height: 16),

              bildLoginButton(),
              SizedBox(height: 24),

              bildSignUpText(),
              SizedBox(height: 24),

              bildOrRaw(),
              SizedBox(height: 34),

              bildGmailButon(),
              SizedBox(height: 24),

              bildSwichLanguage(),
              SizedBox(height: 24),
              bildSwichTheme(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bildAppLogo() => SizedBox(
    height: MediaQuery.of(context).size.height * 0.2,
    child: Image.asset(AppAssets.minLogo),
  );

  Widget bildEmailTextFeald() {
    return CustomTextFeild(
      controler: emailController, //* this to taick its value
      hint:
          AppLocalizations.of(
            context,
          )!.email, //* to read it from localization file if you need translate
      preFixIcon: AppAssets.imailIcon_svg,
    );
  }

  Widget bildPaswordTextFeald() {
    return CustomTextFeild(
      controler: passwordController, //* this to taick its value
      hint:
          AppLocalizations.of(
            context,
          )!.password, //* to read it from localization file if you need translate
      preFixIcon: AppAssets.passwordIcon_svg,
      isPassword: true,
    );
  }

  Widget bildForgetPassword() {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Text(
          AppLocalizations.of(context)!.forgetpassword,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontStyle:
                FontStyle
                    .italic, //* to taik the purble color and medume and italic font
            decoration: TextDecoration.underline,
            color: AppColors.purple, //* to maik an under line
          ),
        ),
      ),
    );
  }

  Widget bildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButtom(
        text: AppLocalizations.of(context)!.login,
        onClick: () async {
          showLoading(context);
          try {
            var userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
            Navigator.push(context, AppRoutes.home);
          } on FirebaseAuthException catch (ex) {
            var message =
                ex.message ?? "some thing went worning , pleas try again leter";
            Navigator.pop(context);
            showMessage(context, content: message, posButtonTitle: "ok");
          }
        },
        textColor: AppColors.white,
      ),
    );
  }

  Widget bildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.dontHaveAcount,
          style: TextTheme.of(context).labelMedium,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, AppRoutes.regester);
          },
          child: Text(
            AppLocalizations.of(context)!.createAccount,
            style: TextTheme.of(context).labelMedium!.copyWith(
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget bildOrRaw() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Divider(indent: 24, endIndent: 24)),
          Text(
            AppLocalizations.of(context)!.or,
            style: TextTheme.of(context).labelMedium,
          ),
          Expanded(child: Divider(indent: 24, endIndent: 24)),
        ],
      ),
    );
  }

  Widget bildGmailButon() {
    return SizedBox(
      width: double.infinity,
      child: CustomButtom(
        ic: AppAssets.google,
        text: AppLocalizations.of(context)!.loginWithgoogle,
        onClick: () {},
        textColor: AppColors.white,
        backgroundColor: AppColors.purple,
      ),
    );
  }

  late LanguageProvider
  languageProvider; //! this to save the language and pass to main( but this is not same obgect in main)
  //* to solv this problem
  Widget bildSwichLanguage() {
    return GestureDetector(
      onTap: () {
        //! change the language when user taps
        final newLang = languageProvider.curentLanguage == "ar" ? "en" : "ar";
        languageProvider.changeLanguage(newLang);
        // setState(() {}); //!!!!! hear not need it becuse we use a inhareted widget
      },
      child: Container(
        //! container for toggle switch
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blue),
          color: AppColors.white, //* background color of switch
          borderRadius: BorderRadius.circular(30), //* rounded edges
        ),
        width: 100, //* width of the switch
        height: 40, //* height of the switch
        child: Stack(
          //! using stack to position the flag
          children: [
            AnimatedAlign(
              //! move the image according to language
              alignment:
                  languageProvider.curentLanguage == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              duration: const Duration(
                milliseconds: 250,
              ), //* animation duration
              curve: Curves.easeInOut, //* animation curve
              child: Image.asset(
                languageProvider.curentLanguage == "ar"
                    ? AppAssets.egept
                    : AppAssets.usa,
                //* choose flag based on language
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  late ThemeProvider themeProvider; //* this to the theme provider
  bildSwichTheme() => AnimatedToggleSwitch<ThemeMode>.dual(
    current: themeProvider.mode,
    iconBuilder:
        (mode) => Icon(
          mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
        ), //* to chose between the modes
    first: ThemeMode.light,
    second: ThemeMode.dark,
    onChanged: (mode) => themeProvider.changeThemeMode(mode),
  );
}
