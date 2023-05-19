import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OneTimePayment extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> donation;

  OneTimePayment({required this.donation});

  @override
  _OneTimePaymentState createState() => _OneTimePaymentState();
}

class _OneTimePaymentState extends State<OneTimePayment> {
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
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment success callback
    String? paymentId = response.paymentId;
    String? orderId = response.orderId;
    String? signature = response.signature;

    // Upload payment details to Firebase Firestore
    FirebaseFirestore.instance
        .collection('payments')
        .doc(widget.donation.id)
        .set({
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
    // Parse the amount inputted by the user
    int amount = int.tryParse(_amountController.text) ?? 0;

    // Create a new Razorpay order
    var options = {
      'key': 'rzp_test_TkUec55gMk4VSv', // Replace with your Razorpay API key
      'amount': amount * 100, // Amount in paise (multiply by 100 for rupees)
      'name': widget.donation['name'],
      'description': 'Donation for ${widget.donation['name']}',
      'prefill': {
        'email': widget.donation['email'], // Replace with the user's email
        'contact':
            widget.donation['phone'], // Replace with the user's contact number
      },
    };

    // Open the Razorpay checkout dialog
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Donation Type',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Donation Amount',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPayment,
              child: Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}
