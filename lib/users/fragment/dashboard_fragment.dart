import 'package:batik/users/fragment/cart_fragment.dart';
import 'package:flutter/material.dart';
import 'package:batik/users/fragment/about_fragment.dart';
import 'package:batik/users/fragment/home_fragment.dart';
import 'package:batik/users/fragment/order_fragment.dart';
import 'package:batik/users/fragment/profile_fragment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:batik/users/userPreferences/current_user.dart';


class DashboardFragment extends StatelessWidget {
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens = [
    const HomeFragment(),
    const CartFragment(),
    OrderFragment(),
    AboutFragment(),
    ProfileFragment(),
  ];

  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.shopping_cart,
      "non_active_icon": Icons.shopping_cart_outlined,
      "label": "Cart",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },
        {
      "active_icon": Icons.info_outline,
      "non_active_icon": Icons.info_outline,
      "label": "About",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(() => _fragmentScreens[_indexNumber.value]),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              items: List.generate(5, (index) {
                var navBtnProperty = _navigationButtonProperties[index];
                return BottomNavigationBarItem(
                    backgroundColor: Colors.orangeAccent,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"]);
              }),
            ),
          ),
        );
      },
    );
  }
}
