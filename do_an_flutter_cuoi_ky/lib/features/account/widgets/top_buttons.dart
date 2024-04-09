import 'package:flutter/material.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/services/account_services.dart';
import 'package:do_an_flutter_cuoi_ky/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Đơn hàng của bạn',
              onTap: () {},
            ),
            AccountButton(
              text: 'Người bán',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Đăng xuất',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Đăng xuất'),
                      content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Không'),
                        ),
                        TextButton(
                          onPressed: () {
                            AccountServices().logOut(context);
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Có'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            AccountButton(
              text: 'Danh sách',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
