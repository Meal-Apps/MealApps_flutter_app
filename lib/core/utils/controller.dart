import 'package:get/get.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:mill_info/api/model_class/for_user/expanses-model.dart';
import 'package:mill_info/api/model_class/for_user/balance-model.dart' as balance;
import 'package:mill_info/api/services/for_manager/manager-all-info.dart';
import 'package:mill_info/api/services/previous-month-data.dart';

class AllDataController extends GetxController {
 static ManagerAllInfo? managerAllInfo ;
 static Expenses? expenses ;
 static balance.Balance? previousBalance ;
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
      var expensesResponse=await getPreviousExpenses();
      var previousBalanceResponse = await getPreviousBalance();
        print("suc controller :  ${response}");
        managerAllInfo=response;
        expenses=expensesResponse;
        previousBalance =previousBalanceResponse;
    } finally {

        isLoading(false);

    }
  }
}
