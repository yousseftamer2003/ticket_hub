import 'package:flutter/material.dart';

class TravelersCounter extends StatefulWidget {
  const TravelersCounter({super.key, Null Function(dynamic value)? onChanged});

  @override
  TravelersCounterState createState() => TravelersCounterState();
}

class TravelersCounterState extends State<TravelersCounter> {
  int travelers = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Number of Travelers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (travelers > 1) {
                    setState(() {
                      travelers--;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$travelers',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    travelers++;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateCard extends StatefulWidget {
  final String? title;
  final Function(String)? onDateSelected;

  const DateCard({super.key, this.title, this.onDateSelected});

  @override
  DateCardState createState() => DateCardState();
}

class DateCardState extends State<DateCard> {
  String? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime firstDate = today;
    DateTime lastDate = DateTime(today.year + 5);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });

      // Call the callback function to pass the selected date to the parent widget
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(selectedDate!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.orange),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title ?? '',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedDate ?? 'Select Date',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String? hint;

  const DropdownCard({
    super.key,
    required this.title,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: Container(height: 2, color: Colors.orange),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            hint: hint != null ? Text(hint!) : null,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class TextFieldCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;

  const TextFieldCard({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 2),
          Container(height: 2, color: Colors.orange), // Orange underline
        ],
      ),
    );
  }
}
