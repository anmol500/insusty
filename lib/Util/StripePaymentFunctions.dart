import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

var paymentIntent;

Future<void> makePayment(context) async {
  try {
    //STEP 1: Create Payment Intent
    paymentIntent = await createPaymentIntent('100', 'USD');

    //STEP 2: Initialize Payment Sheet
    // await Stripe.instance
    //     .initPaymentSheet(
    //         paymentSheetParameters: SetupPaymentSheetParameters(
    //             paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
    //             style: ThemeMode.light,
    //             merchantDisplayName: 'Ikay'))
    //     .then((value) {});

    var sessionData = await Dio().post('https://api.stripe.com/v1/payment_intents?amount=1000&currency=usd',
        options: Options(
          headers: {
            'Authorization': 'Bearer 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',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ));

    var sessionId = sessionData.data['id'];
    await redirectToCheckout(context: context, sessionId: sessionId, publishableKey: 'pk_live_51Ls2MpLiMJsqTuQlmvDZfAE5zec164ebM4a4h2qNYSpuxtYJi92ChmWyan2F62r5mVtWYgf0Y0c2S3HeIlfwSEMD00KbOcSRqH');
    //STEP 3: Display Payment sheet
    displayPaymentSheet(context);
  } catch (err) {
    throw Exception(err);
  }
}

createPaymentIntent(String amount, String currency) async {
  try {
    //Request body
    Map<String, dynamic> body = {
      'amount': (int.parse(amount) * 100).toString(),
      'currency': currency,
    };

    //Make post request to Stripe
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {'Authorization': 'Bearer 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', 'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );
    return json.decode(response.body);
  } catch (err) {
    throw Exception(err.toString());
  }
}

displayPaymentSheet(context) async {
  try {
    await Stripe.instance.presentPaymentSheet().then((value) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100.0,
                    ),
                    SizedBox(height: 10.0),
                    Text("Payment Successful!"),
                  ],
                ),
              ));

      paymentIntent = null;
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  } on StripeException catch (e) {
    print('Error is:---> $e');
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              Text("Payment Failed"),
            ],
          ),
        ],
      ),
    );
  } catch (e) {
    print('$e');
  }
}
