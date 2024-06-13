import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class CategoryModel extends StatelessWidget {
  const CategoryModel({
    super.key,
    required this.sectionName,
  });

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/categories.jpg"),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: appColor,
          borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(0.6)),
        child: Center(
            child: Text(
          // sections[index].name!,
          sectionName,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "cocon-next-arabic"),
        )),
      ),
    );
  }
}
