import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeInputs extends StatefulWidget {
  const DateTimeInputs({Key? key}) : super(key: key);

  @override
  State<DateTimeInputs> createState() => _DateTimeInputsState();
}

class _DateTimeInputsState extends State<DateTimeInputs> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      
      children: [
        SizedBox(height: 15),
        Text(
          "Date and Time",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            ),
          ),
        Row(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedDate != null
                          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                          : "Select Date",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedTime != null
                          ? "${_selectedTime!.hour}:${_selectedTime!.minute}"
                          : "Select Time",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.access_time),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
