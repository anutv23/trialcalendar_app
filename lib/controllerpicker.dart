import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestPickerWidget extends StatefulWidget {
  @override
  _TestPickerWidgetState createState() => _TestPickerWidgetState();
}

class _TestPickerWidgetState extends State<TestPickerWidget> {
  DateTime _selectedDate;
TimeOfDay _selectedTime;
//DateTime _selectedTime;
  TextEditingController _textEditingController = TextEditingController();


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          focusNode: AlwaysDisabledFocusNode(),
          controller: _textEditingController,
          onTap: () {
           // _selectDate(context);
            _selectTime(context);
          },
        ),
      ),
    );
  }

   _selectTime(BuildContext context) async{
    final initialTime = TimeOfDay(hour: 9, minute: 0);
   TimeOfDay newSelectedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime!=null?TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute):initialTime,

      builder: (BuildContext context,Widget child)
{
  return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                    surface: Colors.blueGrey,
                    onSurface: Colors.yellow,
                  ),
                  dialogBackgroundColor: Colors.blue[500],
                ),
                child: child,
              );
}

    );

     if (newSelectedTime != null) {
         _selectedTime = newSelectedTime;
         _textEditingController
      // ..text = _selectedTime.hour.toString().padLeft(2, '0')
         ..text = _selectedTime.hourOfPeriod.toString().padLeft(2,'0')
          // ..text = TimeOfDayFormat.HH_dot_mm.
           ..selection = TextSelection.fromPosition(TextPosition(
               offset: _textEditingController.text.length,
               affinity: TextAffinity.upstream));
       }
   }

  // _selectDate(BuildContext context) async {
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

  //
  //   // if (newSelectedDate != null) {
  //   //   _selectedDate = newSelectedDate;
  //   //   _textEditingController
  //   //     ..text = DateFormat.yMMMd().format(_selectedDate)
  //   //     ..selection = TextSelection.fromPosition(TextPosition(
  //   //         offset: _textEditingController.text.length,
  //   //         affinity: TextAffinity.upstream));
  //   // }
  // }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}