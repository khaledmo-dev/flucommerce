import 'dart:convert';

import 'package:flucommerce/data/models/contact_details.dart';

List<Order> ordersFromJson(List list) =>
    List<Order>.from(list.map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  final int id;
  final int parentId;
  final String number;
  final String status;
  final String dateCreatedGmt;
  final String total;
  final String shippingTotal;
  final String discountTotal;
  final String totalTax;
  final ContactDetails? billing;
  final ContactDetails? shipping;
  final String paymentMethodTitle;
  final List<LineItem> lineItems;

  Order({
    required this.id,
    required this.parentId,
    required this.number,
    required this.status,
    required this.dateCreatedGmt,
    required this.total,
    required this.shippingTotal,
    required this.discountTotal,
    required this.totalTax,
    required this.billing,
    required this.shipping,
    required this.paymentMethodTitle,
    required this.lineItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        parentId: json["parent_id"],
        number: json["number"],
        status: json["status"],
        dateCreatedGmt: json["date_created_gmt"],
        total: json["total"],
        shippingTotal: json["shipping_total"],
        discountTotal: json["discount_total"],
        totalTax: json["total_tax"],
        billing: json["billing"] == null
            ? null
            : ContactDetails.fromJson(json["billing"]),
        shipping: json["shipping"] == null
            ? null
            : ContactDetails.fromJson(json["shipping"]),
        paymentMethodTitle: json["payment_method_title"],
        lineItems: json["line_items"] == null
            ? []
            : List<LineItem>.from(
                json["line_items"]!.map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "number": number,
        "status": status,
        "date_created_gmt": dateCreatedGmt,
        "total": total,
        "shipping_total": shippingTotal,
        "discount_total": discountTotal,
        "total_tax": totalTax,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "payment_method_title": paymentMethodTitle,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}

class LineItem {
  final int id;
  final String? name;
  final int productId;
  final int? variationId;
  final int quantity;
  final String total;
  final int price;

  LineItem({
    required this.id,
    this.name,
    required this.productId,
    this.variationId,
    required this.quantity,
    required this.total,
    required this.price,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        total: json["total"],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "variation_id": variationId ?? 0,
        "quantity": quantity,
      };
}
