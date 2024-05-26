import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 4),
          borderRadius: BorderRadius.circular(35)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
