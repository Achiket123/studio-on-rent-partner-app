import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? leadingCallback;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;
  final Color? bgColor;
  const SimpleAppBar(
      {Key? key,
      required this.title,
      this.leadingCallback,
      this.actions,
      this.titleWidget,
      this.bottom,
      this.bgColor,
      this.centerTitle = true,
      this.showBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return AppBar(
      surfaceTintColor: bgColor,
      backgroundColor: bgColor,
      centerTitle: centerTitle,
      title: titleWidget ??
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: leadingCallback ?? () => Navigator.pop(context),
                child: CircleAvatar(
                  backgroundColor: color.secondary,
                  // width: 20,
                  // height: 20,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: ColorAssets.lightGray.withOpacity(0.5),
                  //       blurRadius: 1,
                  //     ),
                  //   ],
                  // ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
            )
          : null,
      bottom: bottom,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => bottom != null
      ? Size.fromHeight(kToolbarHeight + 56)
      : Size.fromHeight(kToolbarHeight);
}
