import 'package:evently/data/firestore_helpers.dart';
import 'package:evently/models/categort_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/custom_widgets/category_tabs.dart';
import 'package:evently/ui/custom_widgets/event_widget.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CategorytDm selectedCategory = CategorytDm.homeCategories[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildHeader(), Expanded(child: buildEventsList())],
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          buildUserInfo(),
          const SizedBox(height: 10),
          buildCategoryTabs(),
        ],
      ),
    );
  }

  Widget buildUserInfo() => Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back ✨ ",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            UserDm.curentUser!.name,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.white),
              Text(
                "  EtayElbarod , Egypt  ",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      const Spacer(),
      const Icon(Icons.light_mode, color: AppColors.white),
      const SizedBox(width: 10),
      const Icon(Icons.language, color: AppColors.white),
    ],
  );

  Widget buildCategoryTabs() {
    return CategoryTabs(
      onTabSelected: (category) {
        selectedCategory = category;
        setState(() {});
      },
      categories: CategorytDm.homeCategories,
      selectedTabBg: AppColors.white,
      unSelectedTabBg: Colors.transparent,
      selectedTabTextColor: AppColors.babyBlue,
      unselectedTabTextColor: Colors.white,
    );
  }

  Widget buildEventsList() {
    return StreamBuilder<List<EventDm>>(
      stream: getAllEventsFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No events available."));
        }

        var events = snapshot.data!;
        if (selectedCategory.title != "All") {
          events =
              events
                  .where(
                    (event) =>
                        event.category.toLowerCase() ==
                        selectedCategory.title.toLowerCase(),
                  )
                  .toList();
        }

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return EventWidget(eventDm: events[index]);
          },
        );
      },
    );
  }
}
