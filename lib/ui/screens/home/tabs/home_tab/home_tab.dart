import 'package:evently/models/categort_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/custom_widgets/category_tabs.dart';
import 'package:evently/ui/custom_widgets/event_widget.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [bildHeader(), Expanded(child: bildEventsList())]);
  }

  Widget bildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),

      child: Column(
        children: [bildUserInfo(), SizedBox(height: 10), bildCategoresTabs()],
      ),
    );
  }

  Widget bildUserInfo() => Column(
    children: [
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back ✨",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ahmed Ashraf Elraiy",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.white),
                  Text(
                    "  EtayElbarod , Egept  ",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.light_mode, color: AppColors.white),
          SizedBox(width: 10),
          Icon(Icons.language, color: AppColors.white),
        ],
      ),
    ],
  );

  bildCategoresTabs() => Container(
    child: CategoryTabs(
      onTabSelected: (category) {
      },
      categories: CategorytDm.homeCategories, //* this to display the categories
      selectedTabBg: AppColors.white,
      unSelectedTabBg: Colors.transparent,
      selectedTabTextColor: AppColors.babyBlue,
      unselectedTabTextColor: Colors.white,
    ),
  );
  bildEventsList() => ListView.builder(
    itemCount: 4,
    itemBuilder:
        (context, index) => EventWidget(
          eventDm: EventDm(
            title: "this is perth day",
            date: "21\nnov",
            image: AppAssets.minLogo,
            isFavorate: false,
            description: "description",
            lat: 0,
            long: 0,
            time: "time",
          ),
        ),
  );
}
