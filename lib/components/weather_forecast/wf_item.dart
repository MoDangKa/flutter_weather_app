import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WFItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;

  const WFItem(
      {Key? key, required this.time, required this.icon, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              DateFormat.j().format(DateTime.parse(time)),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// '$value°F'