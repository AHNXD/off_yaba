import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/section_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.section,
  });

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(section.image!),
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
            color: Colors.grey.withOpacity(0.5)),
        child: Center(
            child: Text(
          section.name!,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "cocon-next-arabic"),
        )),
      ),
    );
  }
}
