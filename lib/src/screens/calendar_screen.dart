import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // final Map<DateTime, List<CleanCalendarEvent>> _events = {
  //   DateTime(firestore.snap) : [],
  //   DateTime() : []
  // }

  getData() async {
    var result = await FirebaseFirestore.instance
        .collection('notes')
        .doc(Database.userUid)
        .collection('items')
        .orderBy('createdAt', descending: true)
        .get();
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notes')
                .doc(Database.userUid)
                .collection('items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Firebase load fail'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext _context, int index) {
                  print(getData());
                  // var noteInfo = snapshot.data?.docs[index].data()!;
                  // String docID = snapshot.data?.docs[index].id;
                  // String name = (noteInfo as dynamic)['name'];
                  // String recipe = (noteInfo as dynamic)['recipe'];
                  // String date = (noteInfo as dynamic)['date'];
                  return Column(
                    children: <Widget>[
                      Calendar(
                        startOnMonday: true,
                        weekDays: ['월', '화', '수', '목', '금', '토', '일'],
                        onRangeSelected: (range) =>
                            print('Range is ${range.from}, ${range.to}'),
                        // onDateSelected: (date) => _handleNewDate(date),
                        isExpandable: true,
                        eventDoneColor: Colors.green,
                        selectedColor: Colors.pink,
                        todayColor: Colors.blue,
                        eventColor: Colors.grey,
                        locale: 'de_DE',
                        todayButtonText: 'Heute',
                        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                        dayOfWeekStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 11),
                      ),
                      // events: date,
                    ],
                  );
                },
              );
            }));
  }
}
