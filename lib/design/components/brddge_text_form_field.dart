import 'package:brddge/constant/constant.dart';
import 'package:brddge/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

class BrddgeTextFormField extends HookWidget {
  const BrddgeTextFormField({
    required this.inputController,
    required this.inputFocusNode,
    required this.fieldName,
    required this.hintText,
    required this.obscureText,
    super.key,
    this.passwordFocusNode,
    this.textInputAction,
    this.validator,
    this.toggleTextVisibility,
    this.inputType,
    this.helperText,
    this.extraFieldName,
    this.onSaved,
    this.onEditingComplete,
    this.onTapUpOutside,
    this.keyboardType,
  });

  final TextEditingController inputController;
  final FocusNode inputFocusNode;

  final FocusNode? passwordFocusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String fieldName;
  final String hintText;
  final VoidCallback? toggleTextVisibility;
  final bool obscureText;
  final TextInputType? inputType;
  final String? helperText;
  final String? extraFieldName;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(PointerUpEvent)? onTapUpOutside;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: fieldName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: BrddgeColor.white,
                ),
              ),
              if (extraFieldName != null)
                TextSpan(
                  text: extraFieldName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xffF72424),
                  ),
                )
              else
                const TextSpan(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: BrddgeTypeface.bodyText.copyWith(
            color: BrddgeColor.white,
          ),
          keyboardType: keyboardType,
          onTapUpOutside: onTapUpOutside,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: BrddgeColor.textFormFieldFillColor,
            filled: true,
            suffixIcon: toggleTextVisibility == null
                ? null
                : obscureText
                    ? IconButton(
                        icon: SvgPicture.asset(
                          AppConstant.closedEyeSvgPath,
                          semanticsLabel: 'closed eye',
                          // color: Color(0xffACACAC),
                        ),
                        onPressed: () {
                          toggleTextVisibility!();
                        },
                      )
                    : IconButton(
                        icon: SvgPicture.asset(
                          AppConstant.openEyeSvgPath,
                          semanticsLabel: 'open eye',
                          // color: Color(0xffACACAC),
                        ),
                        onPressed: () {
                          toggleTextVisibility!();
                        },
                      ),
            hintText: hintText,
            helperText: helperText,
            helperStyle: const TextStyle(
              color: BrddgeColor.darkGreyishBlue,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            helperMaxLines: 2,
            hintStyle: const TextStyle(
              color: Color(0xff444B58),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: BrddgeColor.darkGreyishBlue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: BrddgeColor.cornsilk,
                width: 1.5,
              ),
            ),
          ),
          controller: inputController,
          focusNode: inputFocusNode,
          textInputAction: textInputAction ?? TextInputAction.next,
          validator: validator,
          
        ),
      ],
    );
  }
}

class AuthValidators {
  static const String emailErrMsg =
      'Invalid Email Address, Please provide a valid email.';
  static const String passwordErrMsg =
      'Password must have at least 6 characters.';
  static const String confirmPasswordErrMsg = "Two passwords don't match.";
  static const usernameErrMsg = 'Username cannot character used';

  String? emailValidator(String? val) {
    final email = val!;

    final emailReg = RegExp(email);

    bool containsSpecialCharacters(String str) {
      final pattern = RegExp(r'[!^&%#()$*]');
      return pattern.hasMatch(str);
    }

    //Check if the length of the email is less than or equal to 3

    if (email.length <= 3) return emailErrMsg;

    if (containsSpecialCharacters(email)) return emailErrMsg;

    // Check if it has @
    // # 4
    final hasAtSymbol = email.contains('@');

    // find the position of @
    // # 5
    final indexOfAt = email.indexOf('@');

    // Check numbers of @
    // # 6
    final numbersOfAt = '@'.allMatches(email).length;

    // Valid if has @
    if (!hasAtSymbol) return emailErrMsg;
    // and  if the number of @ is only 1
    if (numbersOfAt != 1) return emailErrMsg;
    //and if  '@' is not the first or last character
    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    //if it contains value such as #$%!^@&_-

    // Else its valid
    return null;
  }

  // Password validator

  String? passwordWordValidator(String? val) {
    final password = val!;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    // else
    return null;
  }

  // confirm password

  String? confirmPasswordValidator(String? val1, String? val2) {
    final password1 = val1!;
    final password2 = val2!;

    if (password1.isEmpty ||
        password2.isEmpty ||
        password1.length != password2.length) return confirmPasswordErrMsg;

    //  If two passwords do not match then send an error message

    if (password1 != password2) return confirmPasswordErrMsg;

    return null;
  }

  String? usernameValidator(String? val) {
    final username = val!;

    bool containsSpecialCharacters(String str) {
      final pattern = RegExp(r'[!^&%#()$*]');
      return pattern.hasMatch(str);
    }

    if (containsSpecialCharacters(username)) return usernameErrMsg;
    // else
    return null;
  }

  String? requiredFieldValidator(String? val) {
    final value = val!;

    if (value.isEmpty || val.trim().isEmpty) return 'This field is required';

    return null;
  }

  String? phoneNumberValidator(String? val) {
    final phoneNumber = val!;

    if (phoneNumber.isEmpty) return 'Phone number is required';

    if (phoneNumber.length < 11) return 'Phone number is too short';

    if (phoneNumber.length > 11) return 'Phone number is too long';

    return null;
  }
}
