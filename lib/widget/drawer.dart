import 'package:flutter/material.dart';
import 'package:mill_info/screen/create_user_screen.dart';

import '../api/endpoints.dart';
import '../api/services/logout-service.dart';
import '../core/shared_value.dart';
import '../screen/login_screen.dart';
import '../screen/manager-screen.dart';
import '../screen/member-screen.dart';
import '../screen/previous-month-expenses-screen.dart';

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
                  builder: (context) => const MemberScreen()),);
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
                  builder: (context) => const ManagerScreen()),);
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
                    builder: (context) => const PreviousMonthExpensesScreen()));
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
        ):const Text(""),
        //logout
        TextButton.icon(
          onPressed: () {
            isManager.load();
            if(isManager.$){
              LogoutApiService().logout(endpoint: managerLogout);
            }else{
              LogoutApiService().logout(endpoint: userLogout);
            }
            isManager.$=false;
            token.$="";
            token.load();
            isManager.load();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen()),
                    (Route route) => false);
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