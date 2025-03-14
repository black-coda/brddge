import 'package:flutter/material.dart';

class BrddgeButton extends StatelessWidget {
  const BrddgeButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onPressed;
  final String child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(),
              )
            : Text(child),
      ),
    );
  }
}
