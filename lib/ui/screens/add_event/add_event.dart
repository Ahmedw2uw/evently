import 'package:evently/models/categort_dm.dart';
import 'package:evently/ui/custom_widgets/category_tabs.dart';
import 'package:evently/ui/custom_widgets/custom_text_feild.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              bildCategoryImage(),
              bildCategoryTabs(),
              bildTitleTextFeald(),
              bildDescriptionTextFeald(),
              bildEventDate(),
              bildEventTime(),
              bildEventLocation(),
              bildAddEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar bildAppBar() => AppBar(
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.purple),
    title: Center(
      child: Text(
        "Create Event",
        style: TextTheme.of(
          context,
        ).labelMedium!.copyWith(fontSize: 22, fontWeight: FontWeight.normal),
      ),
    ),
  );

  bildCategoryImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(AppAssets.bearthdayBg),
    );
  }

  bildCategoryTabs() {
    return CategoryTabs(
      onTabSelected: (category) {},
      categories:
          CategorytDm.createEventCategories, //* this to display the categories
      selectedTabBg: AppColors.purple,
      unSelectedTabBg: Colors.transparent,
      selectedTabTextColor: AppColors.white,
      unselectedTabTextColor: AppColors.babyBlue,
    );
  }

  bildTitleTextFeald() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "Title",
            style: TextTheme.of(
              context,
            ).titleSmall!.copyWith(color: AppColors.black),
            textAlign: TextAlign.start,
          ),
        ),
        CustomTextFeild(hint: "Event Title", preFixIcon: AppAssets.editTitle),
      ],
    );
  }

  bildDescriptionTextFeald() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "Description",
            style: TextTheme.of(
              context,
            ).titleSmall!.copyWith(color: AppColors.black),
            textAlign: TextAlign.start,
          ),
        ),
        CustomTextFeild(hint: "Event Description", minmumLines: 4),
      ],
    );
  }

  bildEventDate() {
    return Row(
      children: [
        SvgPicture.asset(AppAssets.calender),
        SizedBox(width: 10),
        Text(
          "Event Date",
          style: TextTheme.of(
            context,
          ).titleSmall!.copyWith(color: AppColors.black),
        ),
        Spacer(),
        Text(
          "Choose Date",
          style: TextTheme.of(
            context,
          ).titleSmall!.copyWith(color: AppColors.purple),
        ),
      ],
    );
  }

  bildEventTime() {
    return Row(
      children: [
        SvgPicture.asset(AppAssets.clock),
        SizedBox(width: 10),
        Text(
          "Event Time",
          style: TextTheme.of(
            context,
          ).titleSmall!.copyWith(color: AppColors.black),
        ),
        Spacer(),
        Text(
          "Choose time",
          style: TextTheme.of(
            context,
          ).titleSmall!.copyWith(color: AppColors.purple),
        ),
      ],
    );
  }

  bildEventLocation() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "Location",
            style: TextTheme.of(
              context,
            ).titleSmall!.copyWith(color: AppColors.black),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.purple),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.purple),
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(5),
                ),

                child: Row(children: [SvgPicture.asset(AppAssets.location)]),
              ),
              SizedBox(width: 10),
              Text(
                "Chose the location",
                style: TextTheme.of(
                  context,
                ).titleSmall!.copyWith(color: AppColors.babyBlue),
              ),
              Spacer(),
              Icon(Icons.navigate_next_rounded, color: AppColors.babyBlue),
            ],
          ),
        ),
      ],
    );
  }

  bildAddEventButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Add Event", style: TextTheme.of(context).labelLarge),
      ),
    );
  }
}
