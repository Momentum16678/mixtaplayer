// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// we need to create a new class for it so that our codes wont be too long

class DialogHelper {
  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFFAB35BF),
                  ),
                  SizedBox(height: 8),
                  Text(message ?? 'Logging in...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
