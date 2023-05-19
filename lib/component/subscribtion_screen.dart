import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> donation;
  const SubscriptionScreen({required this.donation});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Razorpay _razorpay;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize Razorpay instance
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    // Cleanup Razorpay instance
    _razorpay.clear();
    _amountController.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment success callback
    String? paymentId = response.paymentId;
    String? orderId = response.orderId;
    String? signature = response.signature;

    // Upload payment details to Firebase Firestore
    FirebaseFirestore.instance.collection('subscriptions').doc().set({
      'paymentId': paymentId,
      'orderId': orderId,
      'signature': signature,
      'userId': widget.donation['userId'], // Replace with the actual user ID
    });

    // Show success message or navigate to a success screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successful'),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment error callback
    int? code = response.code;
    String? message = response.message;

    // Show error message or navigate to an error screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment error: $message'),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // External wallet callback
    String? walletName = response.walletName;

    // Handle external wallet payment if needed
  }

  void _startPayment() {
    // Get the entered amount from the text field
    String enteredAmount = _amountController.text;

    if (enteredAmount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid amount'),
        ),
      );
      return;
    }

    double amount = double.tryParse(enteredAmount) ?? 0.0;

    // Create a new Razorpay order for subscription payment
    var options = {
      'key': 'rzp_test_TkUec55gMk4VSv', // Replace with your Razorpay API key
      'subscription': {
        'plan_id': 'plan_12345', // Replace with your plan ID
      },
      'name': 'Monthly Subscription',
      'description': 'Monthly donation subscription',
      'prefill': {
        'email': widget.donation['email'], // Replace with the user's email
        'contact':
            widget.donation['phone'], // Replace with the user's contact number
      },
      'amount': (amount * 100)
          .toInt(), // Amount in paise (multiply by 100 for rupees)
    };

    // Open the Razorpay checkout dialog
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfeb800),
        title: Text('Monthly Subscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Subscribe for Monthly Donation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Subscription Amount',
                  hintText: 'Enter the amount',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFFfeb800),
                ),
              ),
              onPressed: _startPayment,
              child: Text('Subscribe Now'),
            ),
          ],
        ),
      ),
    );
  }
}
