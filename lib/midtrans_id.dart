import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:midtrans_id/model/transaction.dart';
import 'model/transaction_finished.dart';

enum AliPayEvn { PRODUCTION, SANDBOX }

typedef Future<void> MidtransCallback(TransactionFinished transactionFinished);

class MidtransId {
  static const MethodChannel _channel = const MethodChannel('midtrans_id');
  static final MidtransId _singleton = MidtransId._internal();
  MidtransCallback midtransCallback;

  factory MidtransId() {
    return _singleton;
  }

  MidtransId._internal() {
    _channel.setMethodCallHandler(_methodChannelHandler);
  }

  Future<void> initMidtrans(String clientKey, String merchantUrl,
      {String environtment = 'production'}) async {
    return await _channel.invokeMethod("init", {
      "clientKey": clientKey,
      "merchantUrl": merchantUrl,
      "environtment": environtment,
    });
  }

  Future<void> doPayment(Transaction midtransTransaction) async {
    return await _channel.invokeMethod("doPayment", json.encode(midtransTransaction));
  }

  Future<void> doPaymentWithToken(String token) async {
    return await _channel.invokeMethod("doPaymentWithToken", {
      "token": token,
    });
  }

  Future<dynamic> _methodChannelHandler(MethodCall call) async {
    if (call.method == "onTransactionFinished") {
      if (midtransCallback != null) {
        await midtransCallback(TransactionFinished.fromJson(call.arguments));
      }
    }
    return Future.value(null);
  }

  void finishCallback(MidtransCallback callback) => midtransCallback = callback;
}
