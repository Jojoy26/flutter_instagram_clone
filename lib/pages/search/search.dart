import 'package:flutter/material.dart';
import 'package:flutter_instagram/controllers/search_controller.dart';
import 'package:flutter_instagram/utils/colors/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final controller = Modular.get<SearchController>();

  final controllerTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryDark(),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controllerTextField,
                style: TextStyle(color: AppColors.primaryLight()),
                decoration: InputDecoration(
                  labelText: "Search user",
                  labelStyle: TextStyle(color: AppColors.secondaryDark(), fontSize: 15)
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                controller.getUsersBySearch(controllerTextField.text);
                controllerTextField.clear();
              }, 
              child: Text("Search")
            )
          ],
        )
      ),
      body: Obx((){ 
        if(controller.isLoading.value){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.usersList.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  controller.goToProfile(controller.usersList[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, right: 16, left: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(controller.usersList[index].profile),
                      ),
                      SizedBox(width: 18,),
                      Text(controller.usersList[index].username, style: TextStyle(color: AppColors.primaryLight(), fontSize: 17),)
                    ],
                  ),
                ),
              );
            }
          );
        }
      }),
    );
  }
}