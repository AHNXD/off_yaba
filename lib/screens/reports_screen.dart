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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                isBackable: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30),
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  focusNode: focusNode,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'ارسل رسالة',
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
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      textEditingController.clear();
                      focusNode.unfocus();
                    },
                    icon: const Icon(Icons.report),
                    label: const Text("إرسال")),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 30, left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اخر الردود :",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLines: null,
                      readOnly: true,
                      initialValue:
                          'Occaecat sunt nulla et esse est incididunt sunt laborum qui.. Lorem Lorem aliqua sit adipisicing. Laborum ipsum dolore ipsum cupidatat id et id nulla.',
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: appColor, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: appColor, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: appColor),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
