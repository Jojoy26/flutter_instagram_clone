import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/login_controller.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_instagram/validators/form_validator.dart';
import 'package:flutter_instagram/widgets/custom_button.dart';
import 'package:flutter_instagram/widgets/custom_text_field.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller = Modular.get<LoginController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint){
            return SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "logo",
                        child: SvgPicture.asset("lib/assets/images/ic_instagram.svg", color: AppColors.primaryLight(),),
                      ),
                      SizedBox(height: 35,),
                      CustomTextField(hintText: "Email", formType: FormType.email, onSaved: (dynamic value){controller.email = value;}),
                      SizedBox(height: 15,),
                      CustomTextField(hintText: "Password", formType: FormType.password, onSaved: (dynamic value){controller.password = value;}),
                      SizedBox(height: 60,),
                      Container(
                        height: 50,
                        child: CustomButton(onPressed: (){
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            controller.login();
                          }
                        }, text: "Log In",),
                      ),
                      SizedBox(height: 40,),
                      Align(
                        alignment: Alignment.center,
                        child: Text("OR", style: TextStyle(color: AppColors.secondaryDark()),),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: TextStyle(color: AppColors.secondaryDark())),
                          TextButton(
                            onPressed: (){
                              controller.goToSignUp();
                            }, 
                            child: Text("Sign Up")
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}