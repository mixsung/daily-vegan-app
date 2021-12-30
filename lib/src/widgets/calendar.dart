import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_vegan_app/src/screens/specific_screen.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:daily_vegan_app/src/utils/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  getData() async {
    var result = await FirebaseFirestore.instance
        .collection('notes')
        .doc(Database.userUid)
        .collection('items')
        .orderBy('createdAt', descending: true)
        .get();
    return result;
  }

  late Map<DateTime, List<Event>> selectedEvents;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  // List<Event> _getEventsfromDay(DateTime day) {
  //   // return selectedEvents[date] ?? [];
  //   StreamBuilder<QuerySnapshot>(
  //       stream: Database.readItems(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Text('error');
  //         } else if (snapshot.hasData || snapshot.data != null) {
  //           return ListView.separated(
  //               separatorBuilder: (context, index) => SizedBox(height: 5.0),
  //               itemCount: snapshot.data!.docs.length,
  //               itemBuilder: (context, index) {
  //                 var noteInfo = snapshot.data!.docs[index].data()!;
  //                 String docID = snapshot.data!.docs[index].id;
  //                 String name = (noteInfo as dynamic)['name'];
  //                 String recipe = (noteInfo as dynamic)['recipe'];
  //                 String date = (noteInfo as dynamic)['date'];
  //
  //                 return Ink(
  //                     child: ListTile(
  //                   onTap: () => Navigator.of(context).push(
  //                       // 수정 중
  //                       MaterialPageRoute(
  //                           builder: (context) => SpecificScreen(
  //                                 currentName: name,
  //                                 currentRecipe: recipe,
  //                                 documentId: docID,
  //                                 docDate: date,
  //                               ))),
  //                   title: Text(name),
  //                   subtitle: Text(recipe),
  //                 ));
  //               });
  //         }
  //
  //         return Text('loading');
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          locale: 'ko_KR',
          focusedDay: selectedDay,
          firstDay: DateTime(2021),
          lastDay: DateTime(2040),
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekVisible: true,
          daysOfWeekHeight: 30.0,
          // daysOfWeekStyle:

          //Day Changed
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
            print(focusedDay);
            print(getData());
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },

          // event 넣으면 활성화 하기.
          // eventLoader: _getEventsfromDay,

          //To style the Calendar
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontFamily: 'NotoSerifKR',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              )),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  fontFamily: 'NotoSerifKR',
                  fontWeight: FontWeight.w700,
                  color: Colors.green),
              weekendStyle: TextStyle(
                  fontFamily: 'NotoSerifKR',
                  fontWeight: FontWeight.w700,
                  color: Colors.green)),
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyle(fontFamily: 'NotoSerifKR'),
            outsideTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSerifKR',
                color: Colors.grey),
            defaultTextStyle: TextStyle(
                fontWeight: FontWeight.w700, fontFamily: 'NotoSerifKR'),
            isTodayHighlighted: true,
            todayDecoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.rectangle),
            selectedDecoration: BoxDecoration(
                color: Colors.grey.shade400, shape: BoxShape.rectangle),
            selectedTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'NotoSerifKR',
                fontWeight: FontWeight.w700),
            todayTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'NotoSerifKR',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
