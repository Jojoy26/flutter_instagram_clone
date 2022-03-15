import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/home/home.dart';
import 'package:flutter_instagram/pages/post/post.dart';
import 'package:flutter_instagram/pages/profile/profile.dart';
import 'package:flutter_instagram/pages/search/search.dart';

List<Widget> pagesList = [
  HomePage(),
  SearchPage(),
  PostPage(),
  Container(),
  ProfilePage()
];