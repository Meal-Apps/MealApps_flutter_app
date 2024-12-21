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
 var isAllLoading = true.obs;
 var isPreviousDataLoading = true.obs;
 @override
  void onInit() {
    fetchData();
    fetchPreviousData();
    super.onInit();
  }
  fetchData() async {
    try {
      isAllLoading(true);
      var response = await ApiData().getManagerInfo();
      managerAllInfo=response;
    } finally {
        isAllLoading(false);
    }
  }
 fetchPreviousData()async{
   try{
     isPreviousDataLoading(true);
     var expensesResponse=await getPreviousExpenses();
     var previousBalanceResponse = await getPreviousBalance();
     previousBalance =previousBalanceResponse;
     expenses=expensesResponse;
   }finally{
     isPreviousDataLoading(false);
   }
  }
}
