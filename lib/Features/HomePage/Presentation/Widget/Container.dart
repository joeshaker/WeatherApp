import 'package:flutter/material.dart';
import 'package:weatherapp/Core/Component/defaultText.dart';
import 'package:weatherapp/Core/Utilities/Colors.dart';

class defaultCard extends StatelessWidget {
  final double ?width;
  final double ?height;
  final Color ?color;
  final String ?title;
  final String ?value;

  const defaultCard({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width! ,
      height: height !,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultText(text: title!,fontWeight: FontWeight.w500,fontSize: 18,color: cardColor,),
            defaultText(text: value!,fontSize: 22,fontWeight: FontWeight.bold,)
          ],
        ),
      ),
    );
  }
}