import 'package:get/get.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:mill_info/api/model_class/for_user/expanses-model.dart';
import 'package:mill_info/api/services/for_manager/manager-all-info.dart';
import 'package:mill_info/api/services/previous-month-data.dart';

class AllDataController extends GetxController {
 static ManagerAllInfo? managerAllInfo ;
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  fetchData() async {
    try {
      isLoading(true);
      var response = await ApiData().getManagerInfo();
        print("suc controller :  ${response}");
        managerAllInfo=response;
        // expenses.value=response.expenses;
        // balances.value=response.balance;
        // users.value=response.users;
    } finally {
      if(managerAllInfo!=null){
        isLoading(false);
      }
    }
  }
}
class ExpensesController extends GetxController {
  static Expenses? expenses ;
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  fetchData() async {
    try {
      isLoading(true);
      var response = await getPreviousExpenses();

          print("suc controller :  ${response}");
      expenses = response;
    } finally {
      if(expenses!=null){
        isLoading(false);
      }
    }
  }
}
