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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text("Date and Time"),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: _selectedDate != null
                          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                          : "",
                    ),
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  RegExp regExp = RegExp(
                    r'^(([0-1][0-9])|([2][0-3])):([0-5][0-9]) (AM|PM)$',
                    caseSensitive: false,
                  );
                  if (!regExp.hasMatch(value!)) {
                    return 'Enter a valid time format (12:00 AM/PM)';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Time",
                  hintText: 'Enter time',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
