import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_yaba/models/user_model.dart';
import 'package:off_yaba/services/cache_helper.dart';
import 'package:off_yaba/services/network/auth_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  static const routeName = '/update-user-info';
  const UpdateUserInfoScreen({super.key});

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = UserModel.fromMap(json.decode(CacheHelper.getData(key: "user")));
    _nameController.text = user.name!;
  }

  void _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      final success = await AuthApiService.updateUser({
        'name': _nameController.text,
      });

      if (success) {
        user.name = _nameController.text;
        await CacheHelper.setString(
            key: "user", value: json.encode(user.toMap()));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("لقد حدث خظأ ما يرجى المحاولة لاحقا")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAppBar(
                backArrow: true,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'الاسم',
                      hintText: "الاسم",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (value.length > 50) {
                      return 'Name must be less than 50 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _updateUserInfo,
                child: const Text("تعديل الحساب"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
