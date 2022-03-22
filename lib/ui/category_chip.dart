import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../theme/colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String category =
        Provider.of<AppStateManager>(context).currentCategory;
    final TextStyle? textStyle = Theme.of(context).textTheme.bodySmall;
    final bool isSelected = (category == label.toLowerCase());

    return _BackgroundColorContainer(
      isSelected: isSelected,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: isSelected ? Colors.transparent : const Color(0xFFC6C6C6),
            ),
          ),
          duration: const Duration(milliseconds: 205),
          curve: Curves.easeInOut,
          child: Text(
            label,
            style: textStyle?.copyWith(
              color: isSelected ? Colors.white : AppColors.black,
            ),
          ),
        ),
        onTap: () {
          Provider.of<AppStateManager>(context, listen: false)
              .changeCategory(label.toLowerCase());
        },
      ),
    );
  }
}

class _BackgroundColorContainer extends StatelessWidget {
  final bool isSelected;
  final Widget child;

  const _BackgroundColorContainer({
    Key? key,
    required this.isSelected,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.main : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      duration: const Duration(milliseconds: 315),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
