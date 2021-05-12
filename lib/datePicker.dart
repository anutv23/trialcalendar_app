import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:ui';

import 'calendarDemo.dart';

// class CustomPicker extends CommonPickerModel {
//   String digits(int value, int length) {
//     return '$value'.padLeft(length, "0");
//   }
//
//   CustomPicker({DateTime currentTime, LocaleType locale})
//       : super(locale: locale) {
//     this.currentTime = currentTime ?? DateTime.now();
//     this.setLeftIndex(this.currentTime.hour);
//     this.setMiddleIndex(this.currentTime.minute);
//     this.setRightIndex(this.currentTime.second);
//   }
//
//   @override
//   String leftStringAtIndex(int index) {
//     if (index >= 0 && index < 24) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String middleStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String rightStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }
//
//   @override
//   String leftDivider() {
//     return "|";
//   }
//
//   @override
//   String rightDivider() {
//     return "|";
//   }
//
//   @override
//   List<int> layoutProportions() {
//     return [1, 2, 1];
//   }
//
//   @override
//   DateTime finalTime() {
//     return currentTime.isUtc
//         ? DateTime.utc(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex())
//         : DateTime(
//             currentTime.year,
//             currentTime.month,
//             currentTime.day,
//             this.currentLeftIndex(),
//             this.currentMiddleIndex(),
//             this.currentRightIndex());
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDateTime;
  DateTime _selectedDate;
  bool pressed = false;
  bool pressedstart = false;
  bool pressedend = false;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  TimeOfDay _selectedTime;

  TextEditingController eventcontroller;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    eventcontroller = TextEditingController();
    _selectedEvents = [];
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Meeting Type:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    MeetingType(),
                  ],
                ),
              ),
              TableCalendar(
                events: _events,
                calendarController: _calendarController,
                onDaySelected: (day, events, holidays) {
                  setState(() {
                    _selectedEvents = events;
                  });
                },
              ),
              ..._selectedEvents.map((event) => ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Scheduled meeting is at : ",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(event),
                      ],
                    ),
                  )),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              //     onChanged: (date) {
                              //   print('change $date in time zone ' +
                              //       date.timeZoneOffset.inHours.toString());
                              // },
                              onConfirm: (date) {
                            setState(() {
                              pressed = true;
                              selectedDateTime = date;
                            });
                          }, currentTime: DateTime.now());
                        });
                      },
                      child: Text(
                        'Select Date:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      )),
                  SizedBox(width: 40),
                  pressed
                      ? _displayDateTime(selectedDateTime)
                      : Text("DD/MM/YYYY"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text("Select Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20)),
                    onPressed: () => TimeRangePicker.show(
                      context: context,
                      unSelectedEmpty: false,
                      startTime: TimeOfDay(hour: 00, minute: 00),
                      endTime: TimeOfDay(hour: 00, minute: 00),
                      onSubmitted: (TimeRangeValue value) {
                        setState(() {
                          pressedstart = true;
                          _startTime = value.startTime;
                          _endTime = value.endTime;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  pressedstart
                      ? Text("Start: ${_startTime.hour}:${_startTime.minute}")
                      : Text("hh/min"),
                  SizedBox(
                    width: 20,
                  ),
                  pressedstart
                      ? Text(
                          "End: ${_endTime.hour}:${_endTime.minute}",
                        )
                      : Text("hh/min")
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                    child: Text("Confirm Time"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                  title: Text(
                                      "The meeting scheduled time and date is :"),
                                  content: Text(
                                      '${selectedDateTime.day} / ${selectedDateTime.month} at ${_timeFormated(_startTime)} to ${_timeFormated(_endTime)}'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ]));
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timelapse),
                  border: OutlineInputBorder(),
                  labelText: 'Start Time',
                  //  hintText: 'Enter a valid email
                ),
                controller: eventcontroller,
                onTap: () {
                  _selectTime(context);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (eventcontroller.text.isEmpty) return;
                      if (_events[_calendarController.selectedDay] != null) {
                        _events[_calendarController.selectedDay]
                            .add(eventcontroller.text);
                      } else {
                        _events[_calendarController.selectedDay] = [
                          eventcontroller.text
                        ];
                      }

                      eventcontroller.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            ));
  }

  String _timeFormated(TimeOfDay time) {
    if (time == null) return "--:--";
    return "${time.hour}:${time.minute}";
  }

  _selectTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    TimeOfDay newSelectedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime != null
            ? TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute)
            : initialTime,
        builder: (BuildContext context, Widget child) {
          return child;
        });

    if (newSelectedTime != null) {
      _selectedTime = newSelectedTime;
      eventcontroller
        // ..text = _selectedTime.hour.toString().padLeft(2, '0')
        ..text =
            TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute)
                .toString()
                .padLeft(2, '0')
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: eventcontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  // _selectDate(BuildContext context) async {
  //
  //   DateTime newSelectedDate = await showDatePicker(
  //       context: context,
  //       initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2040),
  //       builder: (BuildContext context, Widget child) {
  //         return Theme(
  //           data: ThemeData.dark().copyWith(
  //             colorScheme: ColorScheme.dark(
  //               primary: Colors.deepPurple,
  //               onPrimary: Colors.white,
  //               surface: Colors.blueGrey,
  //               onSurface: Colors.yellow,
  //             ),
  //             dialogBackgroundColor: Colors.blue[500],
  //           ),
  //           child: child,
  //         );
  //       });
  //
  //   if (newSelectedDate != null) {
  //     _selectedDate = newSelectedDate;
  //     eventcontroller
  //       ..text = DateFormat.yMMMd().format(_selectedDate)
  //       ..selection = TextSelection.fromPosition(TextPosition(
  //           offset: eventcontroller.text.length,
  //           affinity: TextAffinity.upstream));
  //   }
  // }
}

Widget _displayDateTime(selectedDateTime) {
  return Text(
      '${selectedDateTime.day} / ${selectedDateTime.month} / ${selectedDateTime.year}',
      style: TextStyle(fontSize: 15));
}

Widget _displayTime(selectedDateTime) {
  return Text('${selectedDateTime.hour} : ${selectedDateTime.minute}',
      style: TextStyle(fontSize: 15));
}

Widget _displayEndTime(selectedDateTime) {
  return Text('${selectedDateTime.hour} : ${selectedDateTime.minute}',
      style: TextStyle(fontSize: 15));
}
