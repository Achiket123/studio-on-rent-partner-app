import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/otp/login_otp.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';

import '../../../../res/assets.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Positioned(
            top: 88,
            left: 66,
            child: Image.asset(
              ImageAssets.page3,
              width: 290,
              height: 477,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                  child: Material(
                elevation: 15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Discovery",
                            children: [
                              TextSpan(
                                  text: " and Find Your\n",
                                  style: textTheme.titleLarge!
                                      .copyWith(fontSize: 26)),
                              TextSpan(
                                  text: "Perfect Studio",
                                  style: textTheme.titleLarge!.copyWith(
                                      color: color.primary, fontSize: 26)),
                            ],
                            style: textTheme.titleLarge!
                                .copyWith(color: color.primary, fontSize: 26)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // description
                      Text(
                        "App to search and discover the most suitable place for you to stay",
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: color.tertiary),
                      ),
                      const SizedBox(height: 30),
                      CustomTextButton(
                          text: "Let’s Get Started",
                          ontap: () {
                            context.push(LoginOtp.routePath);
                          }),
                      const SizedBox(height: 30),
                      // RichText(
                      //   text: TextSpan(
                      //     text: "Already have an account? ",
                      //     style: textTheme.titleLarge!.copyWith(
                      //         fontWeight: FontWeight.w600, fontSize: 20),
                      //     children: [
                      //       TextSpan(
                      //         text: "Sign In",
                      //         style: textTheme.titleLarge!
                      //             .copyWith(color: color.primary, fontSize: 20),
                      //         recognizer: TapGestureRecognizer()
                      //           ..onTap = () {
                      //             context.push(LoginOtp.routePath);
                      //           },
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
