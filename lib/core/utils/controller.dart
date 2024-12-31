import 'package:get/get.dart';
import 'package:mill_info/api/model_class/for_manager/manager_all_info.dart';
import 'package:mill_info/api/model_class/for_user/balance_model.dart' as balances;
import 'package:mill_info/api/model_class/for_user/expanses-model.dart';
import 'package:mill_info/api/services/previous_month_data.dart';

import '../../api/services/for_manager/manager_all_info.dart';
// class AllDataController extends GetxController {
//  static ManagerAllInfo? managerAllInfo ;
//  static Expenses? expenses ;
//  static balances.Balance? previousBalance ;
//  var isAllLoading = true.obs;
//  var isPreviousDataLoading = true.obs;
//  @override
//   void onInit() {
//     fetchData();
//     fetchPreviousData();
//     super.onInit();
//   }
//   fetchData() async {
//     try {
//       isAllLoading(true);
//       var response = await ApiData().getManagerInfo();
//       managerAllInfo=response;
//     } finally {
//         isAllLoading(false);
//     }
//   }
//  fetchPreviousData()async{
//    try{
//      isPreviousDataLoading(true);
//      var expensesResponse=await getPreviousExpenses();
//      expenses=expensesResponse;
//    }finally{
//      isPreviousDataLoading(false);
//    }
//   }
// }
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
class PreviousMonthExpensesApiController extends GetxController{
  var isLoading = false.obs;
  var expenses = <PreviousMonthExpense>[].obs;
  var totalExpenses = 0.obs;
  @override
  void onInit(){
    fetchData();
    super.onInit();
  }
  Future<void> fetchData()async{
    try{
      isLoading(true);
      var response = await getPreviousExpenses();
      expenses.assignAll(response.previousMonthExpense);
      totalExpenses(response.totalpreviousMonthExpenses );
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
  Manager? manager ;
  var users=<User>[].obs;
  var balance = <Balance>[].obs,expenses=<Expense>[].obs;
  var totalBalance=0.obs,currentBalance=0.obs,totalExpenses = 0.obs;
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
      currentBalance(response.currentBalance);
      totalExpenses(response.totalExpenses);
      users.assignAll(response.users);
      manager = response.manager;
      expenses.assignAll(response.expenses);
      balance.assignAll(response.balance);
    }finally{
      isLoading(false);
    }
  }
  Future<void> refreshData()async{
    await fetchData();
  }
}
