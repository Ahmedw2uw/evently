import 'package:evently/data/firestore_helpers.dart';
import 'package:evently/ui/custom_widgets/event_widget.dart';
import 'package:flutter/material.dart';

class FavorateTab extends StatefulWidget {
  const FavorateTab({super.key});

  @override
  State<FavorateTab> createState() => _FavorateTabState();
}

class _FavorateTabState extends State<FavorateTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: bildEventsList())]);
  }

  Widget bildEventsList() => FutureBuilder(
    future: getFavorateEventsFromFirestore(),
    builder: (context, snapShot) {
      if (snapShot.hasError) {
        return Center(child: Text(snapShot.error.toString()));
      } else if (snapShot.hasData) {
        var events = snapShot.data;
        return ListView.builder(
          itemCount: events?.length,
          itemBuilder: (context, index) {
            return EventWidget(
              eventDm: events![index],
              onFavorateClick: () {
                setState(() {});
              },
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
