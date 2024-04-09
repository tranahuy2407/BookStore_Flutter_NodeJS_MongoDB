import 'dart:convert';

import 'package:do_an_flutter_cuoi_ky/common/widgets/custom_button.dart';
import 'package:do_an_flutter_cuoi_ky/constants/global_variables.dart';
import 'package:do_an_flutter_cuoi_ky/features/cart/widgets/cart_product.dart';
import 'package:do_an_flutter_cuoi_ky/features/cart/widgets/cart_subtotal.dart';
import 'package:do_an_flutter_cuoi_ky/features/home/widgets/address_box.dart';
import 'package:do_an_flutter_cuoi_ky/features/search/screens/search_screen.dart';
import 'package:do_an_flutter_cuoi_ky/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../address/screens/address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController discountCodeController;

  double totalAmount = 0;
  double discountedTotal = 0;

  @override
  void initState() {
    super.initState();
    discountCodeController = TextEditingController();
    calculateTotalAmount(); // Tính tổng cộng khi khởi tạo
  }

  @override
  void dispose() {
    discountCodeController.dispose();
    super.dispose();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(double total) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: total.toStringAsFixed(2),
    );
  }

  Future<void> applyDiscount() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    String discountCode = discountCodeController.text;
    if (discountCode.isNotEmpty) {
      try {
        http.Response res = await http.post(
          Uri.parse('$uri/api/apply-coupon'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({'couponCode': discountCode}),
        );

        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            if (res.statusCode == 200) {
              Map<String, dynamic> data = jsonDecode(res.body);
              print('Data from server: $data'); // In ra dữ liệu từ máy chủ để kiểm tra
              if (data['success'] != null && data['success']) {
                double discountPercentage = data['discountPercentage'] / 100;
                double discountAmount = totalAmount * discountPercentage;
                double discountedTotal = totalAmount - discountAmount;

                setState(() {
                  this.discountedTotal = discountedTotal;
                });

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Số tiền sau khi giảm giá'),
                      content: Text('Tổng cộng: ${discountedTotal.toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Đóng'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Xử lý khi mã giảm giá không hợp lệ từ backend
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Thông báo'),
                      content: Text(data['message']),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Đóng'),
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              // Xử lý khi có lỗi khác từ backend
            }
          },
        );
      } catch (e) {
        // Xử lý khi có lỗi trong quá trình gửi yêu cầu HTTP
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Vui lòng nhập mã giảm giá.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }

  void calculateTotalAmount() {
    final user = context.read<UserProvider>().user;
    totalAmount = 0; // Đặt lại giá trị của totalAmount
    user.cart.forEach((item) {
      totalAmount += item['quantity'] * item['product']['price']; // Tính tổng cộng
    });
    setState(() {}); // Cập nhật giao diện sau khi tính toán tổng cộng
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'TÌm kiếm trong HS BookStore',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            CartSubtotal(initialTotal: totalAmount, discountedTotal: discountedTotal), // Truyền initialTotal và discountedTotal vào CartSubtotal
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Tiến hành mua (${user.cart.length} mặt hàng)',
                onTap: () => navigateToAddress(discountedTotal > 0 ? discountedTotal : totalAmount),
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: discountCodeController,
                      decoration: InputDecoration(
                        labelText: 'Nhập mã giảm giá',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: applyDiscount,
                    child: Text('Áp dụng'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
