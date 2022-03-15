import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/profile_controller.dart';
import 'package:flutter_instagram/models/user_search_model.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final controller = Modular.get<ProfileController>();

  final args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(args == null){
      controller.getAll(null);
    } else {
      final user = args["user"] as UserSearchModel?;
      controller.getAll(user);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryDark(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark(),
        title: Obx(() => Text(!controller.isLoading.value && !controller.hasError.value ? controller.user!.value.username : "")),
      ),
      body: Obx((){
        if(controller.isLoading.value){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if(controller.hasError.value){
          return Container(
            child: Center(
              child: TextButton(
                onPressed: (){},
                child: Text("Try again"),
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            final user = args["user"] as UserSearchModel;
            controller.getAll(user);
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(controller.user!.value.profile),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      label(controller.user!.value.posts.toString(), "posts"),
                                      label(controller.user!.value.followers.length.toString(), "followers"),
                                      label(controller.user!.value.following.length.toString(), "following")
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Obx(() =>
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        child: controller.user!.value.me ? 
                                          ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColors.primaryDark(),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: AppColors.primaryLight(),
                                              ),
                                              borderRadius: BorderRadius.circular(6)
                                            )
                                          ),
                                          onPressed: controller.signOut, 
                                          child: Text("Sing Out")
                                        ) :
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6)
                                            )
                                          ),
                                          onPressed: (){
                                            final user = args["user"] as UserSearchModel;
                                            controller.toggleFollow(user.username);
                                          }, 
                                          child: Obx(() => Text(controller.user!.value.isFollowing ? "Unfollow" : "Follow"))
                                        )
                                      )
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        controller.user!.value.username,
                        style: TextStyle(
                          color: AppColors.primaryLight(),
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                        ),
                      ),
                      Text(
                        controller.user!.value.bio, 
                        style: TextStyle(color: AppColors.primaryLight(0.85), fontSize: 15),
                      )
                    ]
                  )
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
                sliver:  Obx(() => 
                    SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 340 ? 2 : 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    delegate: SliverChildBuilderDelegate(
                      (context, index){
                        return Container(
                          child: Image.network(controller.postsList[index], fit: BoxFit.cover,),
                        );
                      },
                      childCount: controller.postsList.length
                    ),
                    
                  )
                ),
              )
            ],
          ),
        );
      })
    );
  }

  Widget label (String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: AppColors.primaryLight(), fontSize: 18, fontWeight: FontWeight.w600),),
        Text(label, style: TextStyle(color: AppColors.secondaryDark(), fontSize: 15),)
      ],
    );
  }

}

