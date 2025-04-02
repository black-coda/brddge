import 'dart:developer' show log;

import 'package:brddge/app/app.dart';
import 'package:brddge/auth/auth.dart';
import 'package:brddge/design/design.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key, this.initialPage = 0});

  final int initialPage;

  static const path = '/onboard/:initialPage';
  static const initPath = '/onboard/0';
  static const name = 'onboard';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _pageController;
  late int _currentPageIndex;

  @override
  void initState() {
    _currentPageIndex = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
    _pageController.addListener(_updatePageIndex);
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePageIndex);
    super.dispose();
  }

  void _updatePageIndex() {
    setState(() {
      _currentPageIndex = _pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightOfPageView = MediaQuery.sizeOf(context).height * 0.45;
    log('Current Page Index: $heightOfPageView');
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            child: SizedBox(
              child: Placeholder(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 375,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff191919),
                    Color(0xff151515),
                    Color(0xff111111),
                    BrddgeColor.scaffoldBackgroundColor,
                    BrddgeColor.scaffoldBackgroundColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.1, 0.2, 0.4, 0.9],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: onboardWriteUps.entries
                      .map(
                        (entry) => BrddgeGeneralHeader(
                          title: entry.key,
                          subTitle: entry.value,
                        ),
                      )
                      .toList()
                    ..addAll([
                      OnboardingAuthenticationView(
                        isLoginView: _currentPageIndex == 3,
                        pageController: _pageController,
                      ),
                      OnboardingAuthenticationView(
                        isLoginView: _currentPageIndex == 3,
                        pageController: _pageController,
                      ),
                    ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _currentPageIndex <= 1
                ? Container(
                    color: BrddgeColor.scaffoldBackgroundColor,
                    height: heightOfPageView * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardIndicator(
                            currentCardIndex: _currentPageIndex,
                            noOfCards: onboardWriteUps.length,
                          ),
                          SizedBox(
                            width: 80,
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_currentPageIndex == 1) {
                                  context.read<AppBloc>().add(
                                        const AppOnboardingCompleted(),
                                      );
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else if (_currentPageIndex < 2) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Text(
                                'Next',
                                style: BrddgeTypeface.elevatedButtonText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  static Map<String, String> onboardWriteUps = {
    'Event exploration\nmade simple':
        'Discover, book, and track events seamlessly with calendar integration and personalized event curation.',
    'Seamless Networking\nat Events':
        'Effortlessly connect with attendees, explore professional profiles, and expand your network through meaningful interactions.',
  };
}

class OnboardingAuthenticationView extends BrddgeGeneralHeader {
  const OnboardingAuthenticationView({
    required PageController pageController,
    super.title = 'Get Started',
    super.subTitle = 'Register for events and create images of the activities '
        'you plan to attend.',
    super.key,
    this.isLoginView = false,
  }) : _pageController = pageController;

  final bool isLoginView;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        super.build(context), // Retains the original UI
        const SizedBox(height: 28),
        OnboardingAuthenticationButton.google(
          isLoginView: isLoginView,
          onPressed: () {
            // TODO: Implement Google Sign In
          },
        ),
        const SizedBox(height: 12),
        OnboardingAuthenticationButton.email(
          isLoginView: isLoginView,
          onPressed: () {
            log('isLoginView: $isLoginView');
            switch (isLoginView) {
              case true:
                context.pushNamed(
                  LoginWithEmailScreen.name,
                );
              case false:
                context.pushNamed(
                  RegisterWithEmailScreen.name,
                );
            }
          },
        ),
        const SizedBox(height: 12),
        OnboardingAuthenticationButton.phoneNumber(
          isLoginView: isLoginView,
          onPressed: () {},
        ),
        const SizedBox(height: 40),
        Text.rich(
          TextSpan(
            text: isLoginView
                ? "Dont't have and account? "
                : 'Already have an account? ',
            style: BrddgeTypeface.bodyText.copyWith(
              color: BrddgeColor.white,
            ),
            children: [
              TextSpan(
                text: !isLoginView ? 'Log in' : 'Sign up',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _pageController.animateToPage(
                      isLoginView ? 2 : 3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                style: BrddgeTypeface.bodyText.copyWith(
                  color: BrddgeColor.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ]
          .animate(interval: 200.ms)
          .slideY(
            delay: 500.ms,
            duration: 600.ms,
            begin: 1,
          )
          .scale(
            duration: 450.ms,
          ),
    );
  }
}
