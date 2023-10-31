import 'package:flutter/material.dart';

import '../base/validation.dart';
import 'custom_text_field.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    required this.controller,
    this.title = 'Number',
    this.hintText = '123',
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          validateFunction: Validations.validateNumber,
          textInputType: TextInputType.number,
          onChange: onChanged,
        ),
      ],
    );
  }
}
