import 'package:brddge/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrddgeGeneralHeader extends StatelessWidget {
  const BrddgeGeneralHeader({
    required this.title,
    required this.subTitle,
    super.key,
    this.padding = true,
  });

  final String title;
  final String subTitle;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding
          ? const EdgeInsets.only(left: 16, right: 16, top: 16)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: BrddgeTypeface.title.copyWith(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          )
              .animate()
              .fadeIn(
                duration: 500.ms,
                delay: 300.ms,
              ) // uses `Animate.defaultDuration`
              .scale(
                delay: 300.ms,
                duration: 600.ms,
              ) // inherits duration from fadeIn
              .move(
                delay: 300.ms,
                duration: 600.ms,
              ) // runs after the above w/new duration
          , // inherits the delay & duration from move,
          const SizedBox(height: 8),
          Text(
            subTitle,
            style: BrddgeTypeface.subtitle.copyWith(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          )
              .animate()
              .slideY(
                delay: 500.ms,
                duration: 600.ms,
                begin: 1,
              )
              .scale(
                duration: 600.ms,
              ),
        ],
      ),
    );
  }
}
