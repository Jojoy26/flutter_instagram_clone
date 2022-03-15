// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_instagram/validators/form_validator.dart';

class CustomTextField extends StatefulWidget {

  final String hintText;
  final FormType formType;
  final void Function(dynamic value) onSaved;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.formType,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.formType == FormType.password,
      validator: FormValidator.getValidator(widget.formType),
      onSaved: widget.onSaved,
      style: TextStyle(color: AppColors.secondaryDark()),
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.secondaryDark()),
        border: OutlineInputBorder(
          borderSide: BorderSide.none
        )
      ),
    );
  }
}