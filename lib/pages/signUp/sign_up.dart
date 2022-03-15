import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/sign_up_controller.dart';
import 'package:flutter_instagram/pages/signUp/widgets/image_validator.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_instagram/validators/form_validator.dart';
import 'package:flutter_instagram/widgets/custom_button.dart';
import 'package:flutter_instagram/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();
  final controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint){
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 8, left: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "lib/assets/images/ic_instagram.svg",
                        color: AppColors.primaryLight(),
                      ),
                      SizedBox(height: 10,),
                      ImageValidatorField(
                        validator: (File? file){
                          if(file == null){
                            return "Select a profile image";
                          }
                        },
                        onSaved: (File? file){
                          controller.profileImage = file as File;
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                      ),
                      SizedBox(height: 25,),
                      CustomTextField(hintText: "Enter your username",  formType: FormType.username, onSaved: (dynamic value){controller.username = value;},),
                      SizedBox(height: 15,),
                      CustomTextField(hintText: "Enter your email",formType: FormType.email, onSaved: (dynamic value){controller.email = value;}),
                      SizedBox(height: 15,),
                      CustomTextField(hintText: "Enter your password", formType: FormType.password, onSaved: (dynamic value){controller.password = value;}),
                      SizedBox(height: 15,),
                      CustomTextField(hintText: "Enter your bio", formType: FormType.bio, onSaved: (dynamic value){controller.bio = value;}),
                      SizedBox(height: 30,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(onPressed: (){
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            controller.signUp();
                          }
                        }, text: "Sign Up",),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Alread have an account?", style: TextStyle(color: AppColors.secondaryDark())),
                          TextButton(
                            onPressed: (){
                              controller.goToLogin();
                            }, 
                            child: Text("Log In")
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        )
      ),
    );
  }
}