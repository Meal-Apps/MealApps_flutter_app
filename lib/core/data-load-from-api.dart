import 'package:get/get.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/core/utils/controller.dart';

import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../widget/loading.dart';

loadData(){
  token.load();
  isManager.load();
  if(token.$ !=""){
    return Obx((){
      var data = Get.put(AllDataController());
      if(data.isLoading.value){
        return const Loading();
      }else{
        return const HomeScreen();
      }
    });
  }else{
    return const LoginSignupScreen();
  }
}