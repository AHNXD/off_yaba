import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class DetailsListTile extends StatelessWidget {
  const DetailsListTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: appColor),
          ),
          Icon(
            icon,
            color: appColor,
          ),
        ],
      ),
    );
  }
}
