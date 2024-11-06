import 'package:get/get.dart';
import 'package:mill_info/api/model_class/for_user/balance-model.dart';
import 'package:mill_info/api/services/previous-month-data.dart';

class BalanceController extends GetxController {
 static Balance? balance ;
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  fetchData() async {
    try {
      isLoading(true);
      var response = await getPreviousBalance();
      print("suc controller :  ${response}");
      balance=response;
    } finally {
      if(balance!=null){
        isLoading(false);
      }
    }
  }
}
