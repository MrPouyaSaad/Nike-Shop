import 'package:flutter/material.dart';

import 'package:nike_shop/data/model/auth.dart';
import 'package:nike_shop/data/repository/auth_repository.dart';
import 'package:nike_shop/screens/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
      ),
      body: ValueListenableBuilder<AuthModel?>(
        valueListenable: AuthRepository.authNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? 'خوش آمدید'
                    : 'لطفا وارد حساب کاربری خود شوید'),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: const Text('خروج از حساب'))
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          );
                        },
                        child: const Text('ورود'),
                      ),
                // ElevatedButton(
                //     onPressed: () async {
                //       await authRepository.refreshToken(
                //           AuthRepository.authNotifier.value!.refreshToken);
                //     },
                //     child: const Text('Refresh Token')),
              ],
            ),
          );
        },
      ),
    );
  }
}
