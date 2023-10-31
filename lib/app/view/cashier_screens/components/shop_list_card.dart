import 'package:flutter/material.dart';
import 'package:mokpos/app/view/product_model.dart';

import '../../../../widgets/back_button_black.dart';
import '../../../model/shop_item_model.dart';

class ShopListCard extends StatelessWidget {
  final bool showAdd;
  final ProductModel shopItem;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;

  const ShopListCard({
    super.key,
    this.showAdd = true,
    required this.shopItem,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 85,
        width: 40,
        padding: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    shopItem.image!,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopItem.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "CFA ${shopItem.price}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Visibility(
              visible: showAdd,
              child: BlackIconButton(
                onTap: onAdd,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
