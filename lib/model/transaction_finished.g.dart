// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_finished.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionFinished _$TransactionFinishedFromJson(Map<String, dynamic> json) {
  return TransactionFinished(
    json['transactionCanceled'] as bool,
    json['status'] as String,
    json['source'] as String,
    json['statusMessage'] as String,
    json['response'] as String,
    json['deeplinkUrl'] as String,
  );
}

Map<String, dynamic> _$TransactionFinishedToJson(
        TransactionFinished instance) =>
    <String, dynamic>{
      'transactionCanceled': instance.transactionCanceled,
      'status': instance.status,
      'source': instance.source,
      'statusMessage': instance.statusMessage,
      'response': instance.response,
      'deeplinkUrl': instance.deeplinkUrl,
    };
