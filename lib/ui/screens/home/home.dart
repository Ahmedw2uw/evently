import 'package:evently/ui/screens/home/tabs/favorate_tab/favorate_tab.dart';
import 'package:evently/ui/screens/home/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/screens/home/tabs/map_tab/map_tab.dart';
import 'package:evently/ui/screens/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:evently/ui/utiliti/app_routes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curentIndex = 0; //! to chick the curent index
  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    FavorateTab(),
    ProfileTab(),
  ]; //* ths contain all tabs to navigate of the tabs
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[curentIndex], //* to navitate by curent index
        floatingActionButton: bildFloatingActionButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation
                .centerDocked, //* this to maik te button on center button
        bottomNavigationBar: bildBottomNavigationBar(),
      ),
    );
  }

  Widget bildFloatingActionButton() {
    return FloatingActionButton(
      //* to maik floating action button
      shape: StadiumBorder(
        //* to maik the otder is curculer
        side: BorderSide(color: AppColors.white),
      ),

      backgroundColor: AppColors.purple,
      onPressed: () {
        Navigator.push(context,AppRoutes.addEvent);//* to navigate to the this screen 
        
      },
            child: Icon(Icons.add),

    );
  }

  Widget bildBottomNavigationBar() {
    return Theme(
      //* this to giv the app theme but change sum proparty
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.purple,
      ), //! this assin decore for the color of button
      child: BottomNavigationBar(
        currentIndex: curentIndex, //* to change the index
        onTap: (index) {
          curentIndex = index; //* this to change the curent index
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                curentIndex == 0 ? AppAssets.ic_home : AppAssets.normal_home,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                curentIndex == 1 ? AppAssets.ic_activ_map : AppAssets.ic_map,
              ),
            ),
            label: "map",
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                curentIndex == 2
                    ? AppAssets.activ_favorate
                    : AppAssets.ic_favorate,
              ),
            ),
            label: "love",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                curentIndex == 3
                    ? AppAssets.activ_person
                    : AppAssets.normal_person,
              ),
            ),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
