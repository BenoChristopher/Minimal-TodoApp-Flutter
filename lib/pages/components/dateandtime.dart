import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Datetimemonth extends StatelessWidget {
  String getFormattedDateTime() {
    DateTime now = DateTime.now();

    // Format the day with suffix (e.g., 18th)
    String day = DateFormat('d').format(now);
    String suffix;
    if (day.endsWith('1') && day != '11') {
      suffix = 'st';
    } else if (day.endsWith('2') && day != '12') {
      suffix = 'nd';
    } else if (day.endsWith('3') && day != '13') {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    // Combine formatted date and day of the week
    String formattedDate =
        '${day}${suffix} ${DateFormat('MMM yyyy').format(now)}';

    String formattedDay = '${DateFormat('EEEE').format(now)}';

    return '$formattedDate';
  }

  String getFormattedDay() {
    DateTime now = DateTime.now();

    String formattedDay = '${DateFormat('EEEE').format(now)}';

    return '$formattedDay';
  }

  const Datetimemonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getFormattedDateTime(),
              style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 14))),
          Text(
            getFormattedDay(),
            style: GoogleFonts.nunito(
                textStyle:
                    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
