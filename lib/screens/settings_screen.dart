import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/user_model.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/subscriptions_screen.dart';
import 'package:off_yaba/screens/update_user_info_screen.dart';
import 'package:off_yaba/services/cache_helper.dart';
import 'package:off_yaba/services/network/auth_service.dart';
import 'package:off_yaba/widgets/settings_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late UserModel user;
  File? _pickedImage;

  @override
  void initState() {
    user = UserModel.fromMap(json.decode(CacheHelper.getData(key: "user")));
    super.initState();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      bool success = await AuthApiService.uploadUserProfileImage(
          MultipartFile.fromBytes(await pickedFile.readAsBytes(),
              filename: pickedFile.name));
      if (mounted) {
        if (success) {
          setState(() {
            user.image =
                _pickedImage!.path; // Update this with the actual URL if needed
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload image')),
          );
        }
      }
    }
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    bool success = await AuthApiService.deleteImage();
                    if (success) {
                      setState(() {
                        user.image = null;
                      });
                      CacheHelper.setString(
                          key: "user", value: json.encode(user.toMap()));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to delete image')),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    if (user.image != null) {
                      _showImageDialog(user.image!);
                    } else {
                      _pickImage();
                    }
                  },
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: user.image != null
                        ? NetworkImage(user.image!)
                        : _pickedImage != null
                            ? FileImage(_pickedImage!) as ImageProvider
                            : const AssetImage(
                                "assets/images/default-profile.png"),
                  ),
                ),
                title: Text(
                  user.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  user.phoneNumber!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SettingsButton(
            title: "تعديل الملف الشخصي",
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(UpdateUserInfoScreen.routeName);
            },
          ),
          SettingsButton(
            title: "الاشتراكات",
            icon: const Icon(Icons.attach_money),
            onPressed: () {
              Navigator.of(context).pushNamed(SubscriptionsScreen.routeName);
            },
          ),
          SettingsButton(
            title: "المفضلة",
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          SettingsButton(
            title: "الخصوصية",
            icon: const Icon(Icons.privacy_tip),
            onPressed: () {},
          ),
          SettingsButton(
            title: "حول التطبيق",
            icon: const Icon(Icons.info),
            onPressed: () {},
          ),
          SettingsButton(
            title: 'تسجيل الخروج',
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthApiService.logoutUser().then((value) => Navigator.of(context)
                  .pushReplacementNamed(AuthScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
}
