import 'package:flutter/material.dart';
import 'wf_item.dart';

class WFIndex extends StatelessWidget {
  const WFIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Weather Forecast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                WFItem(
                  time: '09:00',
                  icon: Icons.cloud,
                  value: '301.17',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
