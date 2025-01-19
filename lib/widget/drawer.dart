import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_info/screen/create_user_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/endpoints.dart';
import '../api/services/logout_service.dart';
import '../core/shared_value.dart';
import '../screen/login_screen.dart';
import '../screen/manager_screen.dart';
import '../screen/member_screen.dart';
import '../screen/previous_month_expenses_screen.dart';

class Drawer {
   getDrawer(BuildContext context) {
    return NavigationDrawer(
      children: [
        //user
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberScreen()),
            );
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
              MaterialPageRoute(builder: (context) => ManagerScreen()),
            );
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
                    builder: (context) => PreviousMonthExpensesScreen()));
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
        FutureBuilder<bool>(future: getIsManager(),
            builder: (context,snapshot){
          if(snapshot.data==true){
              return   TextButton.icon(
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
              );}else{
            return const SizedBox();
          }
            }),
        //logout
        TextButton.icon(
          onPressed: ()async {
             if (await getIsManager()) {
      logoutfrtomapi(managerLogout,context);
    } else {
      logoutfrtomapi(userLogout,context);
    }

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

   logoutfrtomapi(endpoint,context) {
    LogoutApiService().logout(endpoint: endpoint).then((onValue) {
       SharedPreferences.getInstance().then((prefs) {
        prefs.remove('token');
        prefs.remove('isManager');

    });
       // Get.offAll(LoginSignupScreen());
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginSignupScreen()),(Route<dynamic>route)=>false);
      Fluttertoast.showToast(msg: "${onValue['message']}");
    }).catchError((onError){
      Fluttertoast.showToast(msg: "$onError");

    });
  }
}
