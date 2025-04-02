import 'package:brddge/constant/constant.dart';
import 'package:brddge/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingAuthenticationButton extends StatelessWidget {
  const OnboardingAuthenticationButton(
    this.leadingChild,
    this.trailingChild, {
    required this.onPressed,
    super.key,
    this.isGoogle = false,
  });

  factory OnboardingAuthenticationButton.email({
    required VoidCallback onPressed,
    bool isLoginView = false,
  }) {
    return OnboardingAuthenticationButton(
      const FaIcon(FontAwesomeIcons.envelope, color: BrddgeColor.white),
      isLoginView ? 'Login with email' : 'Sign up with email',
      onPressed: onPressed,
    );
  }

  factory OnboardingAuthenticationButton.phoneNumber({
    required VoidCallback onPressed,
    bool isLoginView = false,
  }) {
    return OnboardingAuthenticationButton(
      const FaIcon(
        FontAwesomeIcons.mobileScreenButton,
        color: BrddgeColor.white,
      ),
      isLoginView ? 'Login with phone number' : 'Sign up with phone number',
      onPressed: onPressed,
    );
  }

  factory OnboardingAuthenticationButton.google({
    required VoidCallback onPressed,
    bool isLoginView = false,
  }) {
    return OnboardingAuthenticationButton(
      SvgPicture.asset(
        AppConstant.googleSvgPath,
        height: 24,
        width: 24,
      ),
      isLoginView ? 'Login with phone number' : 'Sign up with Google',
      onPressed: onPressed,
      isGoogle: true,
    );
  }

  final Widget leadingChild;
  final String trailingChild;
  final VoidCallback onPressed;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isGoogle ? BrddgeColor.white : BrddgeColor.elevatedButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            side: isGoogle
                ? BorderSide.none
                : const BorderSide(
                    color: BrddgeColor.darkGreyishBlue,
                  ),
          ),
          foregroundColor:
              isGoogle ? BrddgeColor.elevatedButtonColor : BrddgeColor.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            leadingChild,
            Text(
              trailingChild,
              style: BrddgeTypeface.elevatedButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
