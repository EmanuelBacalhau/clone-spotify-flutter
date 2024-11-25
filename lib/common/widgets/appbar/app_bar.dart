import 'package:clone_spotify/common/helper/is_dark_mode.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? actions;
  final bool hideBack;
  const BasicAppBar(
      {super.key, this.hideBack = false, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [actions ?? Container()],
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title,
      centerTitle: true,
      leading: hideBack
          ? null
          : IconButton(
              icon: Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  size: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
