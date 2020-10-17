import 'package:json_annotation/json_annotation.dart';

part 'transaction_finished.g.dart';

@JsonSerializable()
class TransactionFinished {
  final bool transactionCanceled;
  final String status;
  final String source;
  final String statusMessage;
  final String response;
  final String deeplinkUrl;

  TransactionFinished(this.transactionCanceled, this.status,
      this.source, this.statusMessage, this.response, this.deeplinkUrl);

  factory TransactionFinished.fromJson(Map<String, dynamic> json) =>
      _$TransactionFinishedFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionFinishedToJson(this);
}
