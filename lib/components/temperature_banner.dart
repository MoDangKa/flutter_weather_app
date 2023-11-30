import 'dart:ui';

import 'package:flutter/material.dart';

class TemperatureBanner extends StatelessWidget {
  final double temp;
  final String sky;

  const TemperatureBanner({Key? key, required this.temp, required this.sky})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$temp K',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Icon(
                    sky == 'Clouds' || sky == 'Rain'
                        ? Icons.cloud
                        : Icons.sunny,
                    size: 48,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    sky,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
