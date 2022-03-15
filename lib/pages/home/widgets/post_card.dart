import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/home/widgets/image_animation.dart';
import 'package:flutter_instagram/pages/home/widgets/like_animation.dart';
import 'package:flutter_instagram/utils/date/format_date.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_instagram/controllers/home_controller.dart';
import 'package:flutter_instagram/models/post_model.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';

class PostCard extends StatefulWidget {

  final int index;

  const PostCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  final homeController = Modular.get<HomeController>();

  Future like() async {
    int postId = homeController.currentPost(widget.index).id;
    await homeController.like(widget.index, postId);
    homeController.updateLikeCount(widget.index, postId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18.sp,
                    backgroundImage: NetworkImage(homeController.postsList[widget.index].value.profile),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    homeController.postsList[widget.index].value.username,
                    style: TextStyle(
                      color: AppColors.primaryLight(),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: (){},
                icon: Icon(Icons.more_vert, color: AppColors.primaryLight(), size: 22.sp,),
              )
            ],
          ),
          SizedBox(height: 5,),
          Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                ),
                height: 200.sp,
                width: double.infinity,
                child: Image.network(homeController.postsList[widget.index].value.media[0], fit: BoxFit.cover,)
              ),
              
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: ImageAnimation(
                  onTap: like,
                  child: Icon(Icons.favorite, color: AppColors.primaryLight(), size: 80,),
                ),
              )
            ],
          ),
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  LikeAnimation(
                    onTap: like,
                    child: Obx(() => 
                      !homeController.postsList[widget.index].value.isLiked ? 
                      Icon(Icons.favorite_border, color: AppColors.primaryLight(), size: 22.sp,) :
                      Icon(Icons.favorite, color: Colors.red, size: 22.sp,)
                    )
                  ),
                  SizedBox(width: 5,),
                  IconButton(
                    padding: EdgeInsets.all(7),
                    constraints: BoxConstraints(),
                    onPressed: (){
                      homeController.goToComments(widget.index, homeController.postsList[widget.index].value.id);
                    }, 
                    icon: Icon(Icons.message_outlined, color: AppColors.primaryLight(), size: 22.sp,)
                  ),
                  SizedBox(width: 8,),
                  IconButton(
                    padding: EdgeInsets.all(7),
                    constraints: BoxConstraints(),
                    onPressed: (){}, 
                    icon: Icon(Icons.send, color: AppColors.primaryLight(), size: 22.sp,)
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: (){}, 
                icon: Icon(Icons.bookmark_border, color: AppColors.primaryLight(), size: 22.sp,)
              ),
            ],
          ),
          SizedBox(height: 3,),
          Container(
            padding: EdgeInsets.only(left: 15, right: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  "${homeController.postsList[widget.index].value.likes.length} likes", 
                  style: TextStyle(color: AppColors.primaryLight(0.85), fontSize: 12.5.sp),),
                ),
                SizedBox(height: 10,),
                Wrap(
                  children: [
                    Text(
                      homeController.postsList[widget.index].value.username,
                      style: TextStyle(
                        color: AppColors.primaryLight(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      homeController.postsList[widget.index].value.caption, 
                      style: TextStyle(color: AppColors.primaryLight(0.85), fontSize: 12.sp),
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Text("View all ${homeController.postsList[widget.index].value.comments.length} comments", style: TextStyle(color: AppColors.secondaryDark(), fontSize: 11.5.sp),),
                SizedBox(height: 7,),
                Text(formatDate(DateTime.parse(homeController.currentPost(widget.index).time)), style: TextStyle(color: AppColors.secondaryDark(), fontSize: 11.sp),),
              ],
            ),
          )
        ],
      ),
    );
  }
}