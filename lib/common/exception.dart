// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppException {
  final String message;
  AppException({
    this.message = 'خطا!',
  });
}

class AppExceptionWidget extends StatelessWidget {
  const AppExceptionWidget({
    super.key,
    required this.onTap,
    required this.exceptionMessage,
  });
  final Function() onTap;
  final String exceptionMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exceptionMessage),
          ElevatedButton(onPressed: onTap, child: const Text('تلاش دوباره')),
        ],
      ),
    );
  }
}
