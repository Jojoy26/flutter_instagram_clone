import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/post_controller.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  final controller = Modular.get<PostController>();
  final controllerTexField = TextEditingController();

  File? photo;

  Future getPhoto(BuildContext context, String type) async {
    final ImagePicker _picker = ImagePicker();
    late XFile? image;
    switch(type){
      case "gallery":
        image = await _picker.pickImage(source: ImageSource.gallery);
        break;
      case "camera":
        image = await _picker.pickImage(source: ImageSource.camera);
        break;
    }
    if(image != null){
      setState(() {
        photo = File(image!.path);
      });
    }
    Navigator.pop(context);
  }

  void onSucess(){
    setState(() {
      photo = null;
    });
  }

  Future showPostDialog(BuildContext context) async {
    await showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 20, bottom: 20),
          backgroundColor: Color(0xFF555555),
          title: Text("Create a Post", style: TextStyle(color: AppColors.primaryLight()),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDialogButton((){getPhoto(context, "camera");},"Take a photo"),
              buildDialogButton((){getPhoto(context, "gallery");},"Choose from gallery"),
              buildDialogButton((){
                Navigator.pop(context);
              },"Cancel"),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: photo != null ? AppBar(
        leading: IconButton(
          onPressed: (){
            setState(() {
              photo = null;
            });
          },
          icon: Icon(Icons.arrow_back)
        ),
        backgroundColor: AppColors.primaryDark(),
        title: Text("Post To"),
        actions: [
          TextButton(
            onPressed: (){
              controller.post(controllerTexField.text, photo, onSucess);
            }, 
            child: Text("Post", style: TextStyle(fontSize: 15),)
          )
        ],
      ) : null,
      backgroundColor: AppColors.primaryDark(),
      body: photo != null ? 
          SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => 
                controller.isLoading.value ? 
                  LinearProgressIndicator(
                    minHeight: 1.4,
                  ) :
                  Container()
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(controller.userController.currentUserModel.profile),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: controllerTexField,
                            style: TextStyle(color: AppColors.primaryLight(0.7)),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Write a caption",
                              hintStyle: TextStyle(color: AppColors.primaryLight(0.9)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryLight()
                                ),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      height: 200.sp,
                      child: Image.file(photo as File, fit: BoxFit.cover,),
                    )
                  ],
                ),
              )
            ],
          ),
        ) : 
          Container(
          alignment: Alignment.center,
          child: InkWell(
              customBorder: CircleBorder(),
              onTap: (){
                showPostDialog(context);
              },
              child: Container(
              
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              ),
              child: Icon(
                  Icons.upload,
                  color: AppColors.secondaryDark(),
                  size: 50,
                ),
            ),
          )
        )
    );
  }

  Widget buildDialogButton(void Function() onPressed, String title){
    return  Container(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 25),
          alignment: Alignment.centerLeft,
          primary: Colors.white
        ),
        onPressed: onPressed, 
        child: Text(title, style: TextStyle(color: AppColors.primaryLight()),)
      ),
    );
  }
}