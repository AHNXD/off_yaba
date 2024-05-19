import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

import 'package:off_yaba/widgets/custom_appbar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  static String routeName = '/reports';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  focusNode: focusNode,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: "ساعدنا في تحسين التطبيق",
                    hintStyle: const TextStyle(color: appColor),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: appColor, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: appColor, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: appColor),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  textEditingController.clear();
                  focusNode.unfocus();
                },
                icon: const Icon(Icons.report),
                label: const Text("إرسال"))
          ],
        ),
      ),
    );
  }
}
