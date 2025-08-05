import 'package:evently/ui/utiliti/app_assets.dart';

class CategorytDm {
  String title;
  String image;
  String background;
  CategorytDm({
    required this.title,
    required this.image,
    required this.background,
  });

  static List<CategorytDm> homeCategories = [
    CategorytDm(
      title: "All",
      image: AppAssets.allCategoris,
      background: AppAssets.workShop,
    ),
    CategorytDm(
      title: "sport",
      image: AppAssets.sport,
      background: AppAssets.sport,
    ),
    CategorytDm(
      title: "Birthday",
      image: AppAssets.bearthday,
      background: AppAssets.bearthdayBg,
    ),
    CategorytDm(
      title: "Book Club",
      image: AppAssets.book,
      background: AppAssets.bearthdayBg,
    ),
  ];
  static List<CategorytDm> createEventCategories = [
    CategorytDm(
      title: "sport",
      image: AppAssets.sport,
      background: AppAssets.spartBg,
    ),
    CategorytDm(
      title: "Birthday",
      image: AppAssets.bearthday,
      background: AppAssets.bearthdayBg,
    ),
    CategorytDm(
      title: "Book Club",
      image: AppAssets.book,
      background: AppAssets.bearthdayBg,
    ),
  ];

  static CategorytDm fromImagePath(String path) {
    return homeCategories.firstWhere(
      (category) => category.image == path || category.background == path,
      orElse:
          () => CategorytDm(
            title: "Unknown",
            image: AppAssets.allCategoris,
            background: AppAssets.background,
          ),
    );
  }

  static CategorytDm fromTitle(String title) {
    return homeCategories.firstWhere(
      (cat) => cat.title.toLowerCase() == title.toLowerCase(),
      orElse: () => homeCategories[0],
    );
  }
}
