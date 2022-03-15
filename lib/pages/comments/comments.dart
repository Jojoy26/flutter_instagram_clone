// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/comment_controller.dart';

import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_instagram/utils/date/format_date.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  final controllerTextField = TextEditingController();

  final args = Get.arguments;

  final controller = Modular.get<CommentController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.commentsList.value = args["commentsList"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back");
        Get.offNamed("/bottomNavigation"); 
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryDark(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.offNamed("/bottomNavigation");          
            }, 
            icon: Icon(Icons.arrow_back)
          ),
          backgroundColor: AppColors.primaryDark(),
          title: Text("Comments"),
        ),
    
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.updateComments(args["postId"]);
                    return Future.value();
                  },
                  child: Obx(() => 
                    ListView.builder(
                    itemCount: controller.commentsList.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 11, bottom: 11, right: 8, left: 8),
                        child: Row(
                          children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(controller.commentsList[index].profile),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      clipBehavior: Clip.antiAlias,
                                      children: [
                                        Text(
                                          controller.commentsList[index].username,
                                          style: TextStyle(
                                            color: AppColors.primaryLight(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          controller.commentsList[index].comment, 
                                          style: TextStyle(color: AppColors.primaryLight(0.80), fontSize: 13.sp),
                                          overflow: TextOverflow.clip,
                                        ),
                                        
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Text(formatDate(DateTime.parse(controller.commentsList[index].time)), style: TextStyle(color: AppColors.secondaryDark(), fontSize: 11.sp),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.favorite, color: Colors.red,)
                            ],
                          ),
                      );
                      }
                    ),
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(controller.userController.currentUserModel.profile)
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      controller: controllerTextField,
                      style: TextStyle(color: AppColors.secondaryDark()),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        hintText: "Comment as ${controller.userController.currentUserModel.username}",
                        hintStyle: TextStyle(color: AppColors.secondaryDark()),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      controller.comment(controllerTextField.text, args["postId"]);
                      controllerTextField.clear();
                    }, 
                    child: Text("Post")
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}