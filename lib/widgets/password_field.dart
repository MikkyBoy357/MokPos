import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../base/constant.dart';
import '../base/validation.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.hintText = 'Au moins 8 characteres',
    this.title = 'Mot de passe',
    this.textInputType = TextInputType.number,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;
  final TextInputType textInputType;
  final void Function(String)? onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Stack(
          children: [
            CustomTextField(
              hintText: widget.hintText,
              controller: widget.controller,
              obscureText: isObscure,
              enabled: true,
              validateFunction: Validations.validatePassword,
              textInputType: widget.textInputType,
              onChange: widget.onChanged,
              // textInputFormatters: [
              //   LengthLimitingTextInputFormatter(
              //     8,
              //   ), //6 is maximum number of characters you want in textfield
              // ],
            ),
            Positioned(
              right: 15,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                child: SvgPicture.asset(
                  "${Constant.assetSvgPath}eye.svg",
                  // color: color,
                  // width: width,
                  // height: height,
                  // fit: boxFit,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
