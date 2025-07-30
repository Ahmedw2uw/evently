import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  final EventDm eventDm;
  const EventWidget({super.key, required this.eventDm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: EdgeInsets.all(8),

      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(eventDm.image)),
        color: AppColors.black,
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
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        eventDm.date,
        style: TextStyle(
          color: AppColors.purple,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
            eventDm.title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          eventDm.isFavorate == true
              ? Icon(Icons.favorite, color: AppColors.babyBlue)
              : Icon(Icons.favorite_border),
        ],
      ),
    );
  }
}
