import 'package:do_an_flutter_cuoi_ky/common/widgets/bottom_bar.dart';
import 'package:do_an_flutter_cuoi_ky/features/address/screens/address_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/admin/screens/add_product_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/auth/screens/auth_screens.dart';
import 'package:do_an_flutter_cuoi_ky/features/home/screens/category_deals_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/home/screens/home_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/order_details/screens/order_details.dart';
import 'package:do_an_flutter_cuoi_ky/features/product_details/screens/product_details_screen.dart';
import 'package:do_an_flutter_cuoi_ky/features/search/screens/search_screen.dart';
import 'package:do_an_flutter_cuoi_ky/models/order.dart';
import 'package:do_an_flutter_cuoi_ky/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Giao diện không tồn tại!'),
          ),
        ),
      );
  }
}