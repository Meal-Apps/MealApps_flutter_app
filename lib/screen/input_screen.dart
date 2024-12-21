import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mill_info/api/services/for_manager/add_balance.dart';
import 'package:mill_info/api/services/for_manager/add_expenses.dart';
import 'package:mill_info/core/utils/controller.dart';
import 'package:mill_info/core/utils/screen_size.dart';
import 'package:mill_info/screen/balance_screen.dart';
import 'package:mill_info/screen/home_screen.dart';
import '../api/model_class/for_manager/search_user-model.dart';
import '../api/services/for_manager/search_user.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  var formKey = GlobalKey<FormState>();
  var inputDetails = TextEditingController();
  var inputPrice = TextEditingController();
  var inputDate = TextEditingController();
  var formKeyBalance = GlobalKey<FormState>();
  var inputName = TextEditingController();
  var inputID = TextEditingController();
  var inputBalance = TextEditingController();
  SearchUser? userData;
  bool isAddBalance = false;
  var userId;
  @override
  void initState() {
    // TODO: implement initState
    var date = DateTime.now();
    var shortedDate = DateFormat.yMMMEd().format(date);
    inputDate.text = shortedDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OUR MIL"),
        leading: IconButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ModalRoute.withName('/'),
                ),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.035,
              ),
              width: MediaQuery.sizeOf(context).width,
              child: TextButton.icon(
                onPressed: () {
                  if (isAddBalance) {
                    setState(() {
                      isAddBalance = false;
                    });
                  } else {
                    setState(() {
                      isAddBalance = true;
                    });
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  size: 15,
                ),
                label: isAddBalance
                    ? const Text("Add Expenses")
                    : const Text("Add balance"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //-------------------------------------------this is add balance form------------------------------------------------//
            isAddBalance
                ? Form(
                    key: formKeyBalance,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              child: TextFormField(
                                controller: inputBalance,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "input some value";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "Enter Balance",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              child: TextFormField(
                                controller: inputName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " input some value";
                                  }
                                  return null;
                                },
                                onChanged: _onchange,
                                decoration: const InputDecoration(
                                    hintText: "Enter name",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                      userData!=null&& userData!.data.isNotEmpty  ?  SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: userData!.data.length,
                            itemBuilder: (context,index){
                            return ListTile(
                              onTap: (){
                                userId= userData!.data[index].id;
                                inputName.text= userData!.data[index].name;
                                userData=null;
                                setState(() {

                                });
                              },
                              title: Text(userData!.data[index].name),
                              subtitle: Text(userData!.data[index].email),
                            );
                          }),
                      ): const Text(""),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.40,
                          height: screenHeight(context)*0.06,
                          child: OutlinedButton(
                            onPressed: () async {
                              if (formKeyBalance.currentState!.validate()) {
                                var balance = AddBalanceApiService().balance(inputBalance.text,userId);
                                balance.then((onValue) {
                                  Fluttertoast.showToast(msg: onValue['message']);
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const BalanceScreen()));
                                  if (kDebugMode) {
                                    print("tis is d $onValue");
                                  }
                                });
                                inputName.clear();
                                inputBalance.clear();
                                inputID.clear();
                              }
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(width: 3, color: Colors.black),
                                ),
                              ),
                            ),
                            child:const Text("Add balance"),
                          ),
                        ),
                      ],
                    ),
                  )
                :

                //this is add expenses form

                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //------------------------------------------------------ date text filed-----------------------------------------

                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              child: TextFormField(
                                controller: inputDate,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " input some value";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Enter Date",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //------------------------------------------------------ price text filed-----------------------------------------
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.30,
                              child: TextFormField(
                                controller: inputPrice,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " input some value";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "Enter Price",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
//------------------------------------------------------ details text filed-----------------------------------------
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.85,
                          child: TextFormField(
                            controller: inputDetails,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " input some value";
                              }
                              return null;
                            },
                            minLines: 2,
                            maxLines: 10,
                            decoration: const InputDecoration(
                                hintText: "Enter Details",
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            isAddBalance==false?  OutlinedButton(
              onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var expenses = AddExpensesApiService().expenses(
                        balance: inputPrice.text,
                        date: inputDate.text,
                        des: inputDetails.text);
                    expenses.then((value) {
                      Get.put(AllDataController());
                      Fluttertoast.showToast(msg: 'Successfully Added');
                    });
                    inputDetails.clear();
                    inputPrice.clear();
                  }
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(width: 3, color: Colors.black),
                  ),
                ),
              ),
              child: const Text("Add Expenses"),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
  _onchange(String value) {
    if(value.isNotEmpty){
      UserSearch().getSearchUser(value).then((onValue) {
        setState(() {
          userData =onValue;
        });
      });
    }else{
      setState(() {
        userData =null;
      });
    }

  }
}
