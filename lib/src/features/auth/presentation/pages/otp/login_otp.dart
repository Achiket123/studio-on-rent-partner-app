import 'dart:async';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_fields/otp_fields.dart';
import 'package:studio_partner_app/src/commons/globals/register_dict.dart';
import 'package:studio_partner_app/src/commons/views/location_access/location_access_page.dart';
import 'package:studio_partner_app/src/commons/views/onboarding/widgets/page1.dart';
import 'package:studio_partner_app/src/commons/views/onboarding/widgets/page2.dart';
import 'package:studio_partner_app/src/commons/views/widgets/simple_app_bar.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/pages/home_view.dart';
import 'package:studio_partner_app/src/features/register/presentation/pages/register.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:timer_button/timer_button.dart';

class LoginOtp extends StatefulWidget {
  static const routePath = '/login-otp';
  const LoginOtp({super.key});

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  int _currentPage = 0;
  Timer? _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String? smsOtp;
  bool requestedOtp = false;
  bool editable = false;
  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
      RegExp regex = RegExp(r'\b\d{6}\b'); // Matches exactly 6 digits

      final match = regex.firstMatch(commingSms!);
      smsOtp = match!.group(0);
      setState(() {});
    } on PlatformException {
      commingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 2),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textColur = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'OTP',
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(
                        ImageAssets.otp,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color.tertiary,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.length != 10 ||
                              int.tryParse(value[0])! < 6) {
                            return 'incorrect phone number';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          _formKey.currentState!.validate();
                        },
                        style: TextStyle(color: textColur.bodyLarge!.color),
                        controller: _controller,
                        maxLength: 10,
                        readOnly: editable,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            hintText: 'phone number',
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          setState(() {
                            editable = false;
                            requestedOtp = false;
                          });
                        },
                      ),
                    ),
                    !requestedOtp
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: color.primary,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () async {
                                  final value = _controller.text.trim();
                                  if (_formKey.currentState!.validate()) {
                                    requestedOtp = !requestedOtp;
                                    editable = true;
                                    context
                                        .read<AuthBloc>()
                                        .add(GetOTP(emailOrPhone: value));

                                    setState(() {});
                                    await initSmsListener();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: SizedBox(
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'Error',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: color.error),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text('Invalid Number')
                                                  ],
                                                ),
                                              ),
                                            ));
                                  }
                                },
                                child: const Text(
                                  'Send Otp',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          )
                        : const SizedBox(
                            height: 30,
                          ),
                    requestedOtp
                        ? OtpFieldsCustom(
                            backgroundColor: color.tertiary,
                            style: TextStyle(color: color.onSurface),
                            autofillOtp: smsOtp,
                            context: context,
                            numberOfFields: 6,
                            onCodeChanged: (otp) {
                              if (state is OtpSuccessState &&
                                  otp == state.otp) {
                                registerDict.addAll(
                                    {"phoneNumber": _controller.text.trim()});
                                context.push(Register.routePath);
                              }
                            })
                        : const SizedBox(),
                    requestedOtp
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: TimerButton(
                                buttonType: ButtonType.textButton,
                                label: 'Resend Otp',
                                onPressed: () {
                                  final value = _controller.text.trim();
                                  context
                                      .read<AuthBloc>()
                                      .add(GetOTP(emailOrPhone: value));

                                  setState(() {});
                                },
                                timeOutInSeconds: 60))
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 500,
                      child: PageView(
                        controller: _pageController,
                        allowImplicitScrolling: true,
                        children: [Page1(), Page2()],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
