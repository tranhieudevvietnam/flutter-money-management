import 'package:flutter/material.dart';

getIconByKey(String key) {
  return materialIcons.entries
      .firstWhere((element) => element.key == key)
      .value;
}

Map<String, IconData> materialIcons = {
  'savings_outlined': Icons.savings_outlined,
  'shopping_cart_outlined': Icons.shopping_cart_outlined,
  'paid_outlined': Icons.paid_outlined,
  'shopping_bag_outlined': Icons.shopping_bag_outlined,
  'redeem_outlined': Icons.redeem_outlined,
  'account_balance_outlined': Icons.account_balance_outlined,
  'local_shipping_outlined': Icons.local_shipping_outlined,
  'store_outlined': Icons.store_outlined,
  'pets_outlined': Icons.pets_outlined,
  'spa_outlined': Icons.spa_outlined,
  'cake_outlined': Icons.cake_outlined,
  'lunch_dining_outlined': Icons.lunch_dining_outlined,
  'local_cafe_outlined': Icons.local_cafe_outlined,
  'delivery_dining_outlined': Icons.delivery_dining_outlined,
  'restaurant_menu_outlined': Icons.restaurant_menu_outlined,
  'restaurant_outlined': Icons.restaurant_outlined,
  'nightlife_outlined': Icons.nightlife_outlined,
  'no_food_outlined': Icons.no_food_outlined,
  'no_drinks_outlined': Icons.no_drinks_outlined,
  'local_gas_station_outlined': Icons.local_gas_station_outlined,
  'oil_barrel_outlined': Icons.oil_barrel_outlined,
  'ev_station_outlined': Icons.ev_station_outlined,
  'tips_and_updates_outlined': Icons.tips_and_updates_outlined,
  'tungsten_outlined': Icons.tungsten_outlined,
  'sports_esports_outlined': Icons.sports_esports_outlined,
  'sports_basketball_outlined': Icons.sports_basketball_outlined,
  'sports_tennis_outlined': Icons.sports_tennis_outlined,
  'sports_baseball_outlined': Icons.sports_baseball_outlined,
  'sports_volleyball_outlined': Icons.sports_volleyball_outlined,
  'gamepad_outlined': Icons.gamepad_outlined,
  'sports_mma_outlined': Icons.sports_mma_outlined,
  'sports_golf_outlined': Icons.sports_golf_outlined,
  'sports_tennis_outlined': Icons.sports_tennis_outlined,
  'sports_handball_outlined': Icons.sports_handball_outlined,
  'smart_toy_outlined': Icons.smart_toy_outlined,
  'casino_outlined': Icons.casino_outlined,
  'bed_outlined': Icons.bed_outlined,
  'night_shelter_outlined': Icons.night_shelter_outlined,
};
