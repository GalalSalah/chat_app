// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca



//a0c5452e0d56478e8d66e68658e56e78
//  https://newsapi.org/v2/top-headlines?country=us&apiKey=a0c5452e0d56478e8d66e68658e56e78




import 'package:chat_app/modules/auth/login.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';

import 'components.dart';

void signOut(context){
  CashHelper.removeDate(key: 'token').then((value) {
    if (value) {
      navigateAndReplacement(context, ChatLoginScreen());
    }
  });
}
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token=CashHelper.getData(key: 'token');
String uid='';