import 'package:flutter/material.dart';

class BrddgeToast {
  factory BrddgeToast() => _instance;

  BrddgeToast._internal();
  // Singleton instance
  static final BrddgeToast _instance = BrddgeToast._internal();

  OverlayEntry? _overlayEntry;

  void show({
    required BuildContext context,
    required String message,
    BrddgeToastType type = BrddgeToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    _removeCurrentToast(); // Ensure only one toast is shown at a time

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: ToastContent(message: message, type: type),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);

    Future.delayed(duration, _removeCurrentToast);
  }

  void _removeCurrentToast() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

enum BrddgeToastType { success, failure, pending }

class ToastContent extends StatelessWidget {
  const ToastContent({required this.message, required this.type, super.key});
  final String message;
  final BrddgeToastType type;

  Color _getBackgroundColor() {
    switch (type) {
      case BrddgeToastType.success:
        return Colors.green;
      case BrddgeToastType.failure:
        return const Color(0xffE50E1A);
      case BrddgeToastType.pending:
        return Colors.orange;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case BrddgeToastType.success:
        return Icons.check_circle;
      case BrddgeToastType.failure:
        return Icons.error;
      case BrddgeToastType.pending:
        return Icons.hourglass_top;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
