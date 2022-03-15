import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class ImageValidatorField extends FormField<File>{
  
  ImageValidatorField({
    required FormFieldSetter<File> onSaved,
    required FormFieldValidator<File> validator,
    File? initialValue,
    required AutovalidateMode autovalidateMode,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<File?> state){
      return Column(
        children: [
          GestureDetector(
            onTap: () async{
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

              if(image != null){
                state.didChange(File(image.path));
              }
            },
            child: CircleAvatar(
              backgroundColor: AppColors.secondaryDark(),
              radius: 50,
              backgroundImage: state.value == null ? AssetImage("lib/assets/images/blank_profile.png") : FileImage(state.value as File) as ImageProvider,
            ),
          ),
          Visibility(
            visible: state.hasError,
            child: SizedBox(height: 5,)
          ),
          state.hasError ? Text(state.errorText as String, style: TextStyle(color: Colors.red),) : Container()
        ],
      );
    }
  );
}