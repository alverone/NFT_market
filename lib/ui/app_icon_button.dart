import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';

class AppIconButton extends StatelessWidget {
  final String imageSrc;
  final void Function()? onTap;
  final Color backgroundColor;
  final bool border;

  const AppIconButton({
    Key? key,
    required this.imageSrc,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          alignment: Alignment.center,
          width: 48,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: border ? AppColors.lightGrey : Colors.transparent,
              width: border ? 1 : 0,
            ),
          ),
          child: SvgPicture.asset(
            imageSrc,
            width: 22,
            height: 22,
          ),
        ),
        splashColor: AppColors.black.withOpacity(0.1),
        hoverColor: AppColors.black.withOpacity(0.1),
      ),
    );
  }
}
