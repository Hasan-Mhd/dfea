import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/component/subscribtion_screen.dart';
import 'package:flutter/material.dart';

import 'component/payment_screen.dart';

class PaymentTypes extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> donation;

  PaymentTypes({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OneTimePayment(
                          donation: donation,
                        ),
                      ),
                    );
                  },
                  child: Text('One Time Donation'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionScreen(
                            donation: donation,
                          ),
                        ),
                      );
                    },
                    child: Text('Mounthly Donation'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
