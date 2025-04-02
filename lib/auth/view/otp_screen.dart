import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/constant/constant.dart';
import 'package:brddge/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

typedef OTPControllerAndNode = ({
  TextEditingController controller,
  FocusNode focusNode,
});

class OTPScreen extends HookWidget {
  const OTPScreen({super.key});

  static const name = 'otp';
  static const path = '/otp';

  @override
  Widget build(BuildContext context) {
    final inputControllers = List<OTPControllerAndNode>.generate(6, (index) {
      return (
        controller: useTextEditingController(),
        focusNode: useFocusNode()
      );
    });

    // Retrieve the passed email
    final emailMap =
        GoRouterState.of(context).extra as Map<String, dynamic>? ?? {};
    final email = emailMap['email'] as String;

    // Create a form key
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: AppConstant.scaffoldPadding(top: 12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrddgeGeneralHeader(
                title: 'Enter Code',
                subTitle: 'We sent a verification code to your email\n$email',
                padding: false,
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemCount: inputControllers.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox.square(
                      dimension: 50,
                      child: TextFormField(
                        controller: inputControllers[index].controller,
                        focusNode: inputControllers[index].focusNode,
                        cursorColor: BrddgeColor.cornsilk,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: BrddgeTypeface.bodyText
                            .copyWith(color: BrddgeColor.white, fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: BrddgeColor.otpTextFormFieldFillColor,
                          counterText: '',
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
                        onChanged: (value) {
                          if (value.isNotEmpty && value.length == 1) {
                            if (index < 5) {
                              inputControllers[index + 1]
                                  .focusNode
                                  .requestFocus();
                            } else {
                              isButtonActive.value = true;
                              inputControllers[index].focusNode.unfocus();
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  text: "You didn't receive any code? ",
                  style: BrddgeTypeface.bodyText.copyWith(
                    color: BrddgeColor.white,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Resend',
                      style: BrddgeTypeface.bodyText.copyWith(
                        color: BrddgeColor.cornsilk,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) async {
                  if (state is AuthenticationFailed) {
                    BrddgeToast().show(
                      context: context,
                      message: state.error,
                      type: BrddgeToastType.failure,
                    );
                  }
                  if (state is AuthenticationOPTSuccess) {
                    context.read<AppBloc>().add(
                          const AppLogoutRequested(),
                        );
                    BrddgeToast().show(
                      context: context,
                      message: 'OTP verification successful, Please login 😁',
                    );
                  }
                },
                builder: (context, state) {
                  return ValueListenableBuilder(
                    valueListenable: isButtonActive,
                    builder: (context, isActive, _) {
                      return BrddgeButton(
                        isActive: isActive,
                        isLoading: state is AuthenticationLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final token = inputControllers.fold<String>(
                              '',
                              (previousValue, element) =>
                                  previousValue + element.controller.text,
                            );
                            context.read<AuthenticationBloc>().add(
                                  OTPAfterRegistrationRequested(
                                    credential: (token, email),
                                  ),
                                );
                          }
                        },
                        text: 'Verify',
                      );
                    },
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

final isButtonActive = ValueNotifier<bool>(false);
