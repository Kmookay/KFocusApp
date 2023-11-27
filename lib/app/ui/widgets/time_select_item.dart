import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TimeSelectItem is a widget that show a time item in the time select list
class TimeSelectItem extends StatefulWidget {
  final String label;
  final Function(DateTime?)? onTimeSelected;
  const TimeSelectItem({super.key, required this.label, this.onTimeSelected});

  @override
  State<StatefulWidget> createState() {
    return TimeSelectItemState();
  }
}

// TimeSelectItemState is a state of TimeSelectItem
class TimeSelectItemState extends State<TimeSelectItem> {
  final DateFormat _dateFormat = DateFormat.yMd().add_Hms();
  DateTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            const Spacer(),
            _selectedTime == null
                ? Row(children: _defaultTimeWidget())
                : Row(children: _selectedTimeWidget())
          ],
        ));
  }

  List<Widget> _defaultTimeWidget() {
    return [
      const SizedBox(width: 10),
      IconButton(
          onPressed: () {
            showDateTimePicker();
          },
          icon: const Icon(Icons.calendar_today))
    ];
  }

  List<Widget> _selectedTimeWidget() {
    return [
      Text(_dateFormat.format(_selectedTime!),
          style: const TextStyle(color: Colors.black)),
      const SizedBox(width: 10),
      IconButton(
          onPressed: () {
            setState(() {
              _selectedTime = null;
              widget.onTimeSelected?.call(null);
            });
          },
          icon: const Icon(Icons.highlight_off))
    ];
  }

  void showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          // Handle the selected date and time here.
          if (selectedTime != null) {
            DateTime result = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            setState(() {
              _selectedTime = result;
              widget.onTimeSelected?.call(result);
            });
          }
        });
      }
    });
  }
}
