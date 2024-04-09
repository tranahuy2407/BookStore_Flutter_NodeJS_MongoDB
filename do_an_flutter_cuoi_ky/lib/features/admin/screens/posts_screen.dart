import 'package:do_an_flutter_cuoi_ky/common/widgets/loader.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/widgets/single_product.dart';
import 'package:do_an_flutter_cuoi_ky/features/admin/screens/add_product_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/admin/services/admin_service.dart';
import 'package:do_an_flutter_cuoi_ky/models/product.dart';
import 'package:flutter/material.dart';

import '../../account/services/account_services.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void logout() {
    AccountServices().logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final productData = products![index];
          return Column(
            children: [
              SizedBox(
                height: 140,
                child: SingleProduct(
                  image: productData.images[0],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      productData.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => deleteProduct(productData, index),
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: navigateToAddProduct,
            tooltip: 'Thêm sách',
          ),
          const SizedBox(height: 16), // Khoảng cách giữa hai nút
          FloatingActionButton(
            child: const Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }
}
