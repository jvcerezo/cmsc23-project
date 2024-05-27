import 'package:flutter/material.dart';

class DateTimeInputs extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final Function(TimeOfDay) onTimeSelected;

  const DateTimeInputs({
    required this.onDateSelected,
    required this.onTimeSelected,
    Key? key,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      onTimeSelected(picked);
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
                      "Select Date",
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
                      "Select Time",
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
