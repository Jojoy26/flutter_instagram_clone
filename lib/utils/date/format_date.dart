import 'package:flutter_instagram/utils/date/months_list.dart';

String formatDate (DateTime date){
  return "${monthsList[date.month]} ${date.day}, ${date.year}";
}