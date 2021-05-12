import 'package:flutter/material.dart';

class calendarClass {
  String caltime;
  String calevent;

  calendarClass({this.caltime, this.calevent});
}

List<calendarClass> eventsday = [
  calendarClass(caltime: "9:00AM", calevent: "Music Class"),
  calendarClass(caltime: "10:00AM", calevent: "PE Class"),
  calendarClass(caltime: "11:00AM", calevent: "Cooking Class")
];
