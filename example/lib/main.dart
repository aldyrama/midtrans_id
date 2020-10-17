import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:midtrans_id/midtrans_id.dart';
import 'package:midtrans_id/model/transaction_finished.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final midtransId = MidtransId();

  @override
  void initState() {
    super.initState();
    doMidtransPayment();
  }

  void doMidtransPayment() {

    /// initialize sdk
    midtransId.initMidtrans(
        "SB-Mid-client-BIe8NUK4XtYR_woU", "http://staging.whizliz.com/");

    /// make payment with token
    midtransId.doPaymentWithToken("bec6fce1-205a-4ea8-8dfe-20a146672bb9").catchError((e) {
      print("error : $e");
    });

    /// return callback from midtrans
    midtransId
        .finishCallback((transaction) => callback(transaction));
  }

  ///callback
  Future<void> callback(TransactionFinished transactionFinished) {
    /// do something
    print("transaction flutter : ${transactionFinished}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
