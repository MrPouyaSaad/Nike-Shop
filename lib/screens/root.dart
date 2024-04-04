import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/common/theme.dart';
import 'package:nike_shop/screens/home/home_screen.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  bool canPop = false;

  Future<bool> _onWillPop(bool isPop) async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return isPop;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return isPop;
    } else {
      setState(() {
        FloatingSnackBar(
          message: 'برای خروج دوبار پشت سر هم دکمه برگشت را بزنید!',
          context: context,
          textColor: Colors.white,
          textStyle: const TextStyle(color: Colors.white),
          duration: const Duration(milliseconds: 3000),
          backgroundColor: LightThemeColors.primaryTextColor,
        );
        canPop = true;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {
            canPop = false;
          }));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(_homeKey, homeIndex, const HomeScreen()),
            _navigator(
                _cartKey,
                cartIndex,
                const Center(
                  child: Text('Cart'),
                )),
            _navigator(
                _profileKey,
                profileIndex,
                const Center(
                  child: Text('Profile'),
                )),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
          ],
          currentIndex: selectedScreenIndex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedScreenIndex);
              _history.add(selectedScreenIndex);
              selectedScreenIndex = selectedIndex;
              canPop = false;
            });
          },
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
