import 'package:email_validator/email_validator.dart';

class FormValidator {

  static String? Function(String? value) getValidator(FormType type) {
    switch(type){
      case FormType.username:
        return (String? value){
          if(value!.isEmpty){
            return "Enter an username";
          }
          if(value.length < 2){
            return "Username must contain at least 2 characters";
          }
        };
      
      case FormType.email:
        return (String? value){
          if(value!.isEmpty){
            return "Enter an email";
          }
          if(!EmailValidator.validate(value)){
            return "Enter a valid email address";
          }
        };
      
      case FormType.password:
        return (String? value){
          if(value!.isEmpty){
            return "Enter an password";
          }
          if(value.length < 6){
            return "Password must contain at least 6 characters";
          }
        };

      case FormType.bio:
        return (String? value){
          if(value!.isEmpty){
            return "Enter an bio";
          }
        };
    }
  }

}

enum FormType {
  username,
  email,
  password,
  bio
}