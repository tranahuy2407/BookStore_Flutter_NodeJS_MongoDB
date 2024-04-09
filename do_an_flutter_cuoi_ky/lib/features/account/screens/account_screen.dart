import 'package:flutter/material.dart';
import 'package:do_an_flutter_cuoi_ky/constants/global_variables.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/widgets/below_app_bar.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/widgets/orders.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logo.JPG',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BelowAppBar(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Orders(),
          ],
        ),
      ),
    );
  }
}
