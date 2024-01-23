import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String title;
  const CustomAppBar({Key? key,this.centerTitle = false, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: ColorManager.darkPrimary2,
      title: Text(title,style: Theme.of(context).textTheme.titleMedium,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
