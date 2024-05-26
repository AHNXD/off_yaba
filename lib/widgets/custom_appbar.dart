import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.isBackable = true,
  });
  final bool isBackable;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
        margin: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: appColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: [
                TextSpan(
                    text: "Off ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [])),
                TextSpan(
                    text: "Yaba",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))
              ]),
            ),
            if (isBackable)
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  )),
          ],
        ));
  }
}
