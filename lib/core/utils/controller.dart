import 'package:get/get.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:mill_info/api/model_class/for_user/expanses-model.dart';
import 'package:mill_info/api/model_class/for_user/balance-model.dart' as balances;
import 'package:mill_info/api/services/for_manager/manager-all-info.dart';
import 'package:mill_info/api/services/previous-month-data.dart';
class AllDataController extends GetxController {
 static ManagerAllInfo? managerAllInfo ;
 static Expenses? expenses ;
 static balances.Balance? previousBalance ;
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
     // var previousBalanceResponse = await getPreviousBalance();
     // previousBalance =previousBalanceResponse;
     expenses=expensesResponse;
   }finally{
     isPreviousDataLoading(false);
   }
  }
}
class PreviousMonthBalanceApiController extends GetxController{
  var isLoading = false.obs;
  var balance = <balances.BalanceElement>[].obs;
  var totalBalance = 0.obs;
  @override
  void onInit(){
    fetchData();
    super.onInit();
  }
  Future<void> fetchData()async{
    try{
      isLoading(true);
      var response = await getPreviousBalance();
      print(response);
      balance.assignAll(response.balances);
      totalBalance(response.totalBalance );
    }finally{
      isLoading(false);
    }
  }
  Future<void> refreshData()async{
    await fetchData();
  }
}

class ApiController extends GetxController{
  var isLoading = false.obs;
  var balance = <Balance>[].obs;
  var totalBalance = 0.obs;
  @override
  void onInit(){
    fetchData();
    super.onInit();
  }
  Future<void> fetchData()async{
    try{
      isLoading(true);
      var response = await ApiData().getManagerInfo();
      totalBalance(response.totalBalance);
      // List v = response.balance;
      balance.assignAll(response.balance);
    }finally{
      isLoading(false);
    }
  }
  Future<void> refreshData()async{
    await fetchData();
  }
}
