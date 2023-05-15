@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

void redirectToCheckout(BuildContext _, priceApi, days, name, points, individual, monthly, price) async {
  // final stripe = Stripe('pk_live_51Ls2MpLiMJsqTuQlmvDZfAE5zec164ebM4a4h2qNYSpuxtYJi92ChmWyan2F62r5mVtWYgf0Y0c2S3HeIlfwSEMD00KbOcSRqH');
  final stripe = Stripe('pk_live_51Ls2MpLiMJsqTuQlmvDZfAE5zec164ebM4a4h2qNYSpuxtYJi92ChmWyan2F62r5mVtWYgf0Y0c2S3HeIlfwSEMD00KbOcSRqH');
  stripe.redirectToCheckout(CheckoutOptions(
    lineItems: [
      LineItem(price: priceApi, quantity: 1),
    ],
    mode: 'payment',
    successUrl: 'https://insusty.com/ThankYouPage/$days/$name/$points/$individual/$monthly/$price',
    cancelUrl: 'https://insusty.com/Offset',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
