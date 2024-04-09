
import 'package:do_an_flutter_cuoi_ky/common/widgets/custom_textfield.dart';
import 'package:do_an_flutter_cuoi_ky/constants/global_variables.dart';
import 'package:do_an_flutter_cuoi_ky/constants/utils.dart';
import 'package:do_an_flutter_cuoi_ky/features/address/services/address_service.dart';
import 'package:do_an_flutter_cuoi_ky/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final AddressServices addressService = AddressServices();

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Hoặc',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Số nhà, Ấp, Phường',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Xã, Huyện, Quận',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Tỉnh/Thành phố',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => payPressed(address, PaymentMethod.CashOnDelivery),
                child: Text('Thanh toán khi nhận hàng'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => payPressed(address, PaymentMethod.BankPayment),
                child: Text('Thanh toán bằng VNPay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void payPressed(String addressFromProvider, PaymentMethod paymentMethod) async {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${flatBuildingController.text}, ${areaController.text}, ${cityController.text}';
      } else {
        showSnackBar(context, 'Vui lòng nhập tất cả các trường!');
        return;
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Lỗi');
      return;
    }
    if (paymentMethod == PaymentMethod.CashOnDelivery) {
      await performCashOnDelivery();
    } else if (paymentMethod == PaymentMethod.BankPayment) {
      await performBankPayment();
    }
  }

  Future<void> performCashOnDelivery() async {
    if (addressToBeUsed.isEmpty) {
      showSnackBar(context, 'Vui lòng nhập địa chỉ giao hàng!');
      return;
    }
    addressService.saveUserAddress(context: context, address: addressToBeUsed);
    addressService.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
      paymentMethod: "Thanh toán khi nhận hàng",
    );
  }

  Future<void> performBankPayment() async {
    if (addressToBeUsed.isEmpty) {
      showSnackBar(context, 'Vui lòng nhập địa chỉ giao hàng!');
      return;
    }
    // Thực hiện thanh toán bằng VNPay hoặc các phương thức khác ở đây
  }
}

enum PaymentMethod {
  CashOnDelivery,
  BankPayment,
}
