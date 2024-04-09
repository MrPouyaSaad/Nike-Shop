// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:nike_shop/common/theme.dart';
import 'package:nike_shop/data/repository/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  TextStyle textFieldStyle = TextStyle(color: LightThemeColors.onBackgroud);
  final TextEditingController usernameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = LightThemeColors.onBackgroud;
    return Theme(
      data: themeData.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: (onBackground),
            foregroundColor: (themeData.colorScheme.secondary),
          ),
        ),
        colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: onBackground),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: onBackground, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: onBackground, width: 1)),
        ),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/nike_logo.png',
                color: Colors.white,
                width: 120,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: const TextStyle(
                    color: onBackground,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: const TextStyle(color: onBackground, fontSize: 14),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: usernameController,
                style: textFieldStyle,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('آدرس ایمیل'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _PasswordTextField(
                onBackground: onBackground,
                passwordController: passwordController,
                textFieldStyle: textFieldStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  await authRepository.login(
                    username: usernameController.text,
                    password: passwordController.text,
                  );
                },
                child: Text(
                  isLogin ? 'ورود' : 'ثبت نام',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                      style: TextStyle(color: onBackground.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: TextStyle(
                        color: themeData.colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: themeData.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
    required this.passwordController,
    required this.textFieldStyle,
  }) : super();

  final Color onBackground;
  final TextEditingController passwordController;
  final TextStyle textFieldStyle;
  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      style: widget.textFieldStyle,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            icon: Icon(
              obsecureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.onBackground.withOpacity(0.6),
            )),
        label: const Text('رمز عبور'),
      ),
    );
  }
}
