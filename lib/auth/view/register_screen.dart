import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/constant/constant.dart';
import 'package:brddge/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class RegisterWithEmailScreen extends HookWidget {
  const RegisterWithEmailScreen({super.key});

  static const String path = '/registerWithEmail';
  static const String name = 'registerWithEmail';

  @override
  Widget build(BuildContext context) {
    final emailInputController = useTextEditingController();
    final emailInputFocusNode = useFocusNode();
    final passwordInputController = useTextEditingController();
    final passwordInputFocusNode = useFocusNode();
    final controller = ScrollController();
    final isButtonActive = useState(false);
    final shouldSaveSession = useState(false);
    final formKey = GlobalKey<FormState>();
    final vKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: BrddgeColor.white,
          ),
          onPressed: () => context.pushNamed(
            OnboardScreen.name,
            pathParameters: {
              'initialPage': '3',
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Form(
          key: formKey,
          child: Padding(
            padding: AppConstant.scaffoldPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue with email',
                  style: BrddgeTypeface.title.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ), // inherits the delay & duration from move,
                const SizedBox(height: 8),
                Text(
                  'Enter your email and password to '
                  'sign up '
                  'and start exploring',
                  key: vKey,
                  style: BrddgeTypeface.subtitle.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 36),
                BrddgeTextFormField(
                  inputController: emailInputController,
                  inputFocusNode: emailInputFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  fieldName: 'Email',
                  hintText: 'Enter email address',
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  validator: AuthValidators().emailValidator,
                  onEditingComplete: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      passwordInputFocusNode.requestFocus,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BrddgeTextFormField(
                  inputController: passwordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  inputFocusNode: passwordInputFocusNode,
                  fieldName: 'Password',
                  hintText: 'Enter a secured password',
                  obscureText: true,
                  validator: AuthValidators().passwordWordValidator,
                  onEditingComplete: () {
                    if (formKey.currentState!.validate()) {
                      isButtonActive.value = true;
                      passwordInputFocusNode.unfocus();
                    }
                  },
                  onTapUpOutside: (event) {
                    if (formKey.currentState!.validate()) {
                      isButtonActive.value = true;
                      passwordInputFocusNode.unfocus();
                    }
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // save login session
                    Row(
                      spacing: 8,
                      children: [
                        Checkbox(
                          value: shouldSaveSession.value,
                          onChanged: (value) {
                            shouldSaveSession.value = value!;
                          },
                          activeColor: BrddgeColor.cornsilk,
                          checkColor: BrddgeColor.richBlack,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            color: BrddgeColor.cornsilk,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: BrddgeColor.cornsilk,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationFailed) {
                      BrddgeToast().show(
                        context: context,
                        message: state.error,
                        type: BrddgeToastType.failure,
                      );
                    }
                    if (state is AuthenticationSuccess) {
                      context.pushNamed(
                        OTPScreen.name,
                        extra: {
                          'email': emailInputController.text,
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return BrddgeButton(
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(
                              RegisterWithEmailRequested(
                                credential: (
                                  emailInputController.text,
                                  passwordInputController.text,
                                  {}
                                ),
                              ),
                            );
                      },
                      text: 'Continue',
                      isActive: isButtonActive.value,
                      isLoading: state is AuthenticationLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
