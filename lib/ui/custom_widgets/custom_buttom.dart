import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Function() onClick;
  final Color textColor;
  final String? ic;

  const CustomButtom({
    super.key,
    this.backgroundColor = AppColors.purple,
    required this.text,
    required this.onClick,
    required this.textColor,
    this.ic,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(),
      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          if (ic != null) ...[
            Image.asset(ic!, width: 24, height: 24, fit: BoxFit.contain),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              text,
              
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(inherit: true, color: textColor),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
      //* to taik thame style but defrent color
    );
  }
}
