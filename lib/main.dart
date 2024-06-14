import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpay_apay/payment_configuration.dart';
import 'package:pay/pay.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    const _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
    String platform;
    if (defaultTargetPlatform == TargetPlatform.android) {
      platform = 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      platform = 'ios';
    } else {
      platform = 'unknown';
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: platform == 'android'
              ? GooglePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (paymentResult) => onGooglePayResult(context, paymentResult),
                )
              : ApplePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onApplePayResult,
        ),
      ),
    )
    );
  }

  void onApplePayResult(paymentResult) {
  // Send the resulting Apple Pay token to your server / PSP
}

void onGooglePayResult(BuildContext context, paymentResult) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Google Pay Result'),
        content: Text('Payment Result: $paymentResult'),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
