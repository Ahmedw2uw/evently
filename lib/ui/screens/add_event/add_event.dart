import 'package:evently/data/firestore_helpers.dart';
import 'package:evently/models/categort_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/custom_widgets/category_tabs.dart';
import 'package:evently/ui/custom_widgets/custom_buttom.dart';
import 'package:evently/ui/custom_widgets/custom_text_feild.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:evently/ui/utiliti/dialog_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategorytDm selectedCategory = CategorytDm.createEventCategories[0];
  DateTime selectedDate =
      DateTime.now(); //* this is assin the curent date in it

  TimeOfDay selectedTime = TimeOfDay.now();

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
              SizedBox(height: 16),
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
      child: Image.asset(selectedCategory.background),
    );
  }

  bildCategoryTabs() {
    return CategoryTabs(
      onTabSelected: (category) {
        selectedCategory = category;
        setState(() {});
      },
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
        CustomTextFeild(
          hint: "Event Title",
          preFixIcon: AppAssets.editTitle,
          controler: titleController,
        ),
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
        CustomTextFeild(
          hint: "Event Description",
          minmumLines: 4,
          controler: descriptionController,
        ),
      ],
    );
  }

  bildEventDate() {
    return InkWell(
      onTap: () async {
        selectedDate =
            (await showDatePicker(
              //* this to display the date calender
              context: context,
              initialDate: selectedDate, //* the first date
              firstDate: DateTime.now(), //* the first date
              lastDate: DateTime.now().add(
                Duration(days: 365),
              ), //* the curent date+365day
            )) ??
            selectedDate; //* to cannot be nul
      },
      child: Row(
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
      ),
    );
  }

  bildEventTime() {
    return InkWell(
      onTap: () async {
        selectedTime =
            (await showTimePicker(
              context: context,
              initialTime: selectedTime,
            )) ??
            selectedTime; //*this to display the thime like clock
      },
      child: Row(
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
      ),
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
    return CustomButtom(
      text: "Add Event",
      onClick: () async {
        showLoading(context);
        try {
          EventDm eventDm = EventDm(
            id: UserDm.curentUser!.id,
            title: titleController.text,
            date: selectedDate,
            category: selectedCategory.image,
            description: descriptionController.text,
            time: selectedTime,
            ownerId: UserDm.curentUser!.id,
          );

          await addEventToFirestore(eventDm);
          if (!mounted)
            return; //* this to chick firest if the widget is stil live or dide to notreturnnull

          Navigator.pop(context); // لإغلاق الـ loading
          Navigator.pop(context); // لإغلاق الـ loading
        } catch (e) {
          Navigator.pop(context); // نغلق الـ loading
          showMessage(context, content: "Error: $e", posButtonTitle: "ok");
        }
      },
      textColor: AppColors.white,
    );
  }
}
// SizedBox(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       showLoading(context);

    //       try {
    //         EventDm eventDm = EventDm(
    //           id: "",
    //           title: titleController.text,
    //           date: selectedDate,
    //           image: selectedCategory.image,
    //           description: descriptionController.text,
    //           time: selectedTime,
    //         );

    //         await addEventToFirestore(eventDm);

    //         Navigator.pop(context); // لإغلاق الـ loading
    //       } catch (e) {
    //         Navigator.pop(context); // نغلق الـ loading
    //         showMessage(context, content: "Error: $e", posButtonTitle: "ok");
    //       }
    //     },
    //     // child: Text("Add Event", style: TextTheme.of(context).labelLarge),
    //     child: Text("enter"),
    //   ),
    // );