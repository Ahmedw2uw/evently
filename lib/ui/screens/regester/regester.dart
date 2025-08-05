import 'package:evently/data/firestore_helpers.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/custom_widgets/custom_buttom.dart';
import 'package:evently/ui/custom_widgets/custom_text_feild.dart';
import 'package:evently/ui/provider/language_provider.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:evently/ui/utiliti/app_routes.dart';
import 'package:evently/ui/utiliti/dialog_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  //! to taik the text in fealds we must assin the controllers to all fealds
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePassowdController = TextEditingController();
  //* must contains to the text fealds => assign thear fealds

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(
      context,
      listen: true, //* this is assin to this page is lisner to the notyfylisner
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.createAccount,
          style: TextTheme.of(context).titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.background),
            fit: BoxFit.fill,
          ),
        ),

        child: Form(
          child: ListView(
            padding: EdgeInsets.all(16),

            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(AppAssets.minLogo),
              ),
              SizedBox(height: 24),
              CustomTextFeild(
                controler:
                    userNameController, //*(controler)=> this taik the enterd valu and assign it to the email and name
                hint: AppLocalizations.of(context)!.name,
                preFixIcon: AppAssets.personIcon_svg,
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controler: emailController, //*controler
                hint: AppLocalizations.of(context)!.email,
                preFixIcon: AppAssets.imailIcon_svg,
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controler: passwordController, //*controler
                hint: AppLocalizations.of(context)!.password,
                preFixIcon: AppAssets.passwordIcon_svg,
                isPassword: true,
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                controler: rePassowdController, //*controler

                hint: AppLocalizations.of(context)!.password,
                preFixIcon: AppAssets.passwordIcon_svg,
                isPassword: true,
              ),
              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: CustomButtom(
                  text: AppLocalizations.of(context)!.createAccount,
                  onClick: () async {
                    showLoading(context);
                    try {
                      //! this function (createUserWithEmailAndPassword) is return (user creditional)=> this have obgect with type user =>and contain email and id (this in fire base there is important )

                      var userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            //* this is a getter method to assin the email and passowr  in firebase
                            email:
                                emailController
                                    .text, //! the all error is handel in the firebase
                            password: passwordController.text,
                          );
                    UserDm.curentUser = UserDm(
                        id:
                            userCredential
                                .user!
                                .uid, //* this to get id of  the user auth
                        name: userNameController.text,
                        email: emailController.text,
                        favorateEvents: []//*------
                      );
                      addUserToFirestore(
                        UserDm.curentUser!,
                      ); //* this to add the user to firestore
                      if (!context.mounted) return;
                      Navigator.pop(context); //! this lines to hide loading
                      Navigator.push(
                        context,
                        AppRoutes.home,
                      ); //*if every thing ok go to home
                    } on FirebaseAuthException catch (exiption) {
                      //* this is a differnt exiption to catch the firebase ex (this return a code exption )
                      var message = "some Thing went rong ,pleas try again";

                      if (exiption.code == 'weak-password') {
                        message = 'The password provided is too weak.';
                      } else if (exiption.code == 'email-already-in-use') {
                        message = 'The account already exists for that email.';
                      }
                      Navigator.pop(context); //! this lines to hide loading

                      showMessage(
                        context,
                        content: message,
                        posButtonTitle: "ok",
                      ); //* this to show the error in the dialog
                    }

                    // await Future.delayed(
                    //   const Duration(seconds: 3),
                    // ); //* this to before 2 second pop it
                    // Navigator.pop(context);
                    // showMessage(
                    //   context,
                    //   title: "title",
                    //   content: "content",
                    //   posButtonTitle: "ok",
                    //   negButtonTitle: "cancle",
                    // );
                    // Navigator.push(context, AppRoutes.home);
                  },
                  textColor: AppColors.white,
                ),
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAcount,
                    style: TextTheme.of(context).titleMedium,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, AppRoutes.login);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextTheme.of(context).labelMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Align(alignment: Alignment.center, child: bildSwichLanguage()),
            ],
          ),
        ),
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
          color: Colors.transparent, //* background color of switch
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
}
