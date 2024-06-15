import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/categories_screen.dart';
import 'package:off_yaba/widgets/custom_search_deleget.dart';

class CustomAppBar extends StatefulWidget {
  final bool backArrow ;
  final bool bell ;
  final bool search ;
  final bool cameraSettings ;

  const CustomAppBar({
    super.key,
    this.backArrow = false,
    this.bell = false,
    this.search = false,
    this.cameraSettings = false,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
            gradient: const LinearGradient(colors: [Colors.blue, appColor]),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        width: double.infinity,
        child: Column(
          children: [
            widget.backArrow && !widget.bell
                ? Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          )),
                      const Spacer(
                        flex: 1,
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
                      const Spacer(
                        flex: 1,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                          )),
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
                    ],
                  ),
            widget.search
                ? Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => showSearch(
                              context: context,
                              delegate: StoreSearchDelegate()),
                          icon: const Icon(Icons.search),
                          label: const Text("البحث"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                          child: VerticalDivider(
                            thickness: 2,
                            width: 16,
                            color: Colors.grey,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pushNamed(
                              context, CategoriesScreen.routeName),
                          icon: const Icon(Icons.category_outlined),
                          label: const Text("الأقسام"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            widget.cameraSettings
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                camOn = !camOn;
                                camOncolor = camOn ? Colors.green : Colors.red;
                                if (camOn) {
                                  controller?.resumeCamera();
                                } else {
                                  controller?.stopCamera();
                                }
                              });
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: camOncolor,
                            )),
                        IconButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          icon: FutureBuilder<bool?>(
                            future: controller?.getFlashStatus(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data != null) {
                                return snapshot.data!
                                    ? const Icon(
                                        Icons.flash_on,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.flash_off,
                                        color: Colors.red,
                                      );
                              } else {
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.red,
                                );
                              }
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.switch_camera,
                              color: appColor,
                            ))
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ));
  }
}
