import 'package:evently/models/categort_dm.dart';
import 'package:flutter/material.dart';

class CategoryTabs extends StatefulWidget {
  final List<CategorytDm> categories; //* list of desplays categories
  final Function(CategorytDm)
  onTabSelected; //* when user select the tab will return category dm
  final Color selectedTabBg;
  final Color unSelectedTabBg;
  final Color selectedTabTextColor;
  final Color unselectedTabTextColor;

  const CategoryTabs({
    super.key,
    required this.onTabSelected,
    required this.categories,
    required this.selectedTabBg,
    required this.unSelectedTabBg,
    required this.selectedTabTextColor,
    required this.unselectedTabTextColor,
  });

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  late CategorytDm
  selectedCategory; //* hear we have a broplem the list of category cannot acces in the (state class) => acces by widget.-> this tipe is category tabs (can accse in eny place)
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.categories[0]; //* to maik firest item is selected
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (index) {
          selectedCategory =
              widget.categories[index]; //* when click chage th curent index
          widget.onTabSelected(
            selectedCategory,
          ); //* this is acall back function is call to change the selected category when click
          setState(() {});
        },
        isScrollable:
            true, //* to can scrol in the tab bar and donnt need to draw all in one time
        indicatorColor:
            Colors
                .transparent, //* this to ermove the under line with the selected category
        dividerColor:
            Colors.transparent, //* to remove the devider under the row
        tabAlignment: TabAlignment.start, //* to align from start
        tabs:
            widget.categories
                .map(
                  (category) => mapCategoryDmToTab(
                    category,
                    category ==
                        selectedCategory, //* when this is == selected category
                  ),
                )
                .toList(),
      ),
    ); //*this to can pass boolian baramitter to can parse list of catDm=> to list of widget

    //* this to convert the list to list of widget
  }

  // List <CategorytDm> cat=CategorytDm.homeCategories;
  Widget mapCategoryDmToTab(CategorytDm category, bool isSelected) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(46),
          color: isSelected ? widget.selectedTabBg : widget.unSelectedTabBg,
          border: Border.all(color: widget.selectedTabBg, width: 1),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(category.image),
              color:
                  isSelected
                      ? widget.selectedTabTextColor
                      : widget.unselectedTabTextColor,
            ), //* it a same text color
            SizedBox(width: 8),
            Text(
              category.title,
              style: TextStyle(
                color:
                    isSelected
                        ? widget.selectedTabTextColor
                        : widget.unselectedTabTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
