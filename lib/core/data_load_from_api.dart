import 'package:mill_info/core/shared_value.dart';
import '../screen/login_screen.dart';
loadData(screenClassName){
  token.load();
  isManager.load();
  if(token.$ !=""){
   return screenClassName;
  }else{
    return const LoginSignupScreen();
  }
}