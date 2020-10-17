import 'package:json_annotation/json_annotation.dart';

import 'customer.dart';
import 'item.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final Customer customer;
  final List<Item> productItem;
  final int totalPrice;

  Transaction(this.customer, this.productItem, this.totalPrice);

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}