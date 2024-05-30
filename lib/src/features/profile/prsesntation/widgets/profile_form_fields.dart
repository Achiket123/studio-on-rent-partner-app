

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/register/presentation/pages/register.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_text_button.dart';
import 'package:studio_partner_app/src/utils/widgets/form_text_field.dart';

class ProfileFormFields extends StatefulWidget {
  final VoidCallback save;
  const ProfileFormFields({super.key, required this.save});

  @override
  State<ProfileFormFields> createState() => _ProfileFormFieldsState();
}

class _ProfileFormFieldsState extends State<ProfileFormFields> {
  String selectedGender = 'm';
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController numberEditingController =
      TextEditingController(text: 'phoneNumber');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Key textField = const Key('number');
  @override
  void dispose() {
    nameEditingController.dispose();
    numberEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        key: _formKey,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // if (state is AuthFailure) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text(state.message)));
            // }
            // if (state is AuthSuccess) {
            //   user = state.user;
            //   print(user);
            //   context.go(HomeView.routePath);
            // }
          },
          builder: (context, state) {
            // if (state is LoadingState) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormTextField(
                    controller: emailEditingController,
                    labelText: "email",
                  ),
                  FormTextField(
                    controller: nameEditingController,
                    labelText: "Name",
                  ),
                  FormTextField(
                    labelText: "Gender",
                    child: DropdownButton(
                      value: selectedGender,
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 'f',
                          onTap: () => setState(() {
                            selectedGender = 'f';
                          }),
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorAssets.blackFaded,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "m",
                          onTap: () => setState(() {
                            selectedGender = 'm';
                          }),
                          child: const Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (data) {},
                    ),
                  ),
                  FormTextField(
                    controller: numberEditingController,
                    labelText: "Phone Number",
                    child: Row(
                      children: [
                        // DropdownButton(
                        //   icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w600,
                        //     color: ColorAssets.blackFaded,
                        //   ),
                        //   underline: const SizedBox(),
                        //   items: const [DropdownMenuItem(child: Text("+91"))],
                        //   onChanged: (val) {},
                        // ),
                        Container(
                          margin: const EdgeInsets.only(left: 3, right: 5),
                          height: 20,
                          width: 2,
                          color: ColorAssets.black,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: numberEditingController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 67),
                    child: CustomTextButton(
                      bgColor: ColorAssets.primaryBlue,
                      text: "Complete Profile",
                      ontap: () {
                        // if (_formKey.currentState!.validate()) {
                        //   if (numberEditingController.text.length != 10) {
                        //     numberEditingController.text = 'invalid number';
                        //     return;
                        //   }
                        //   widget.save();
                        //   userDetails.addAll({
                        //     'createdAt': DateTime.now(),
                        //     'gender': selectedGender,
                        //     'email': emailEditingController.text.trim(),
                        //     'name': nameEditingController.text.trim()
                        //   });
                        //   log(userDetails.toString());
                        //   context.read<AuthBloc>().add(SignUpEvent(
                        //       params: SignUpParams.fromMap(userDetails)));

                        // context.push(HomeView.routePath);
                        // }
                        context.push(Register.routePath);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
