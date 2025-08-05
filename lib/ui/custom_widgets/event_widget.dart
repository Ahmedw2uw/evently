import 'package:evently/data/firestore_helpers.dart';
import 'package:evently/models/categort_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/utiliti/app_assets.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  final EventDm eventDm;
  final Function? onFavorateClick;
  const EventWidget({super.key, required this.eventDm, this.onFavorateClick});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    CategorytDm categorytDm = CategorytDm.fromImagePath(
      widget.eventDm.category,
    );
    CategorytDm category = CategorytDm.fromTitle(widget.eventDm.category);

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: EdgeInsets.all(8),

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(categorytDm.background),
          fit: BoxFit.cover,
        ),

        color: AppColors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [bildDate(), Spacer(), bildTitle()],
      ),
    );
  }

  Widget bildDate() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            widget.eventDm.date.day.toString(),
            style: TextStyle(
              color: AppColors.purple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            getMoonthName(widget.eventDm.date.month),
            style: TextStyle(
              color: AppColors.purple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getMoonthName(int month) {
    const List<String> months = [
      "jan",
      "fep",
      "mur",
      "apr",
      "may",
      "jun",
      "jul",
      "aug",
      "sep",
      "oct",
      "nov",
      "des",
    ];
    return months[month - 1];
  }

  Widget bildTitle() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.eventDm.title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          bildFavorateIcon(),
        ],
      ),
    );
  }

  Widget bildFavorateIcon() {
    bool isFavorate = UserDm.curentUser!.favorateEvents.contains(
      widget.eventDm.id,
    );

    return InkWell(
      onTap: () async {
        if (UserDm.curentUser == null) return;
        widget.onFavorateClick?.call();
        if (isFavorate) {
          await removeEventFromFavorates(widget.eventDm.id);
        } else {
          await addEventToFavorates(widget.eventDm.id);
        }

        setState(() {}); // يحدث الأيقونة
      },
      child: ImageIcon(
        AssetImage(
          isFavorate ? AppAssets.ic_favorate : AppAssets.activ_favorate,
        ),
        color: AppColors.babyBlue,
      ),
    );
  }
}
