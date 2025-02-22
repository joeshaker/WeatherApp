import 'package:flutter/material.dart';
import 'package:weatherapp/Core/Component/defaultText.dart';

class RowItem extends StatelessWidget {
  final String? todayText; // Text for "Today"
  final String? humidityText; // Text for humidity percentage
  final String? maxTemp; // Max temperature
  final String? minTemp; // Min temperature
  final IconData? icon; // Optional icon

  const RowItem({
    super.key,
    this.todayText,
    this.humidityText,
    this.maxTemp,
    this.minTemp,
    this.icon = Icons.water_drop_sharp, // Default icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space evenly
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date or Today Label
          Expanded(
            flex: 2,
            child: defaultText(
              text: todayText ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              textAlign: TextAlign.start, // Align left
            ),
          ),

          // Weather Icon & Humidity
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: Colors.blue),
                const SizedBox(width: 5),
                defaultText(
                  text: humidityText ?? "",
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),

          // Max Temperature
          Expanded(
            flex: 1,
            child: defaultText(
              text: maxTemp ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              textAlign: TextAlign.center,
            ),
          ),

          // Min Temperature
          Expanded(
            flex: 1,
            child: defaultText(
              text: minTemp ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
