import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/home_controller.dart';
import 'package:flutter_instagram/pages/home/widgets/post_card.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getPosts();
  }
  

  @override
  Widget build(BuildContext context) {

    print(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.primaryDark(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark(),
        title: SvgPicture.asset(
          "lib/assets/images/ic_instagram.svg",
          width: 100,
          color: AppColors.primaryLight(),
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.messenger_outline_sharp, color: AppColors.primaryLight(),)
          )
        ],
      ),
      body: Obx(() {
          if(controller.postsList.isNotEmpty && !controller.isLoading.value){
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getPosts();
                return Future.value();
              },
              child: ListView.builder(
                itemCount: controller.postsList.length,
                itemBuilder: (context, index){
                  return PostCard(index: index,);
                }
              ),
            );
          } else if(controller.isLoading.value) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if(controller.postsList.isEmpty && !controller.isLoading.value && !controller.hasError.value){
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No posts to show", style: TextStyle(color: AppColors.primaryLight(), fontSize: 20),),
                    TextButton(
                      onPressed: controller.getPosts, 
                      child: Text("Load Posts", style: TextStyle(fontSize: 16),)
                    )
                  ],
                )
              ),
            );
          } else if(controller.hasError.value) {
            return Container(
              child: Center(
                child: TextButton(
                  onPressed: controller.getPosts, 
                  child: Text("Try again", style: TextStyle(fontSize: 16),)
                ),
              ),
            );
          }

          return Container();
        } 
      )
    );
  }
}