import 'package:brddge/design/brddge_color.dart';
import 'package:flutter/material.dart';

class BrddgeButton extends StatelessWidget {
  const BrddgeButton({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    super.key,
    this.isActive = true,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? BrddgeColor.cornsilk
              : BrddgeColor.elevatedDisabledButtonColor,
          foregroundColor: BrddgeColor.richBlack,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator.adaptive(),
              )
            : Text(text),
      ),
    );
  }
}
