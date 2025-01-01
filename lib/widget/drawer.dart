import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_info/screen/create_user_screen.dart';
import 'package:get/get.dart';
import '../api/endpoints.dart';
import '../api/services/logout_service.dart';
import '../core/shared_value.dart';
import '../screen/login_screen.dart';
import '../screen/manager_screen.dart';
import '../screen/member_screen.dart';
import '../screen/previous_month_expenses_screen.dart';

class Drawer {
 static getDrawer(BuildContext context){
   isManager.load();
   return NavigationDrawer(
      children: [
        //user
        TextButton.icon(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  MemberScreen()),);
          },
          label: const Text(
            "Members",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            Icons.people_alt_rounded,
            size: 20,
          ),
        ),
        //manager
        TextButton.icon(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  ManagerScreen()),);
          },
          label: const Text(
            "Manager",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            Icons.people_alt_rounded,
            size: 20,
          ),
        ),
        // previous month expenses
        TextButton.icon(
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  PreviousMonthExpensesScreen()));
          },
          label: const Text(
            "Previous Month Expenses",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            Icons.sell,
            size: 20,
          ),
        ),
        //Create user screen
       isManager.$? TextButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserCreateScreen()));
          },
          label: const Text(
            "Create User",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            Icons.person_add_alt_rounded,
            size: 20,
          ),
        ):const SizedBox(height: 0,),
        //logout
        TextButton.icon(
          onPressed: () {
            isManager.load();
            if(isManager.$){
              LogoutApiService().logout(endpoint: managerLogout).then((onValue){
                isManager.$=false;
                token.$="";
                Fluttertoast.showToast(msg: "${onValue['message']}");
              });
            }else{
              LogoutApiService().logout(endpoint: userLogout).then((onValue){
                isManager.$=false;
                token.$="";
                Fluttertoast.showToast(msg: "${onValue['message']}");
              });
            }
            token.load();
            isManager.load();
            Get.offAll(LoginSignupScreen());
          },
          label: const Text(
            "Logout",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(
            Icons.logout_outlined,
            size: 20,
          ),
        )
      ],
    );
  }
}