import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/donation_types_screen.dart';
import 'package:flutter/material.dart';

import 'component/payment_screen.dart';

class DonationDetailsScreen extends StatelessWidget {
  late QueryDocumentSnapshot<Object?> donation;

  DonationDetailsScreen({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: '${donation['name']}',
                child: Container(
                  height: 250,
                  child: Image(
                    image: NetworkImage(
                      donation['photoUrl'],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('${donation['name']}'),
              Card(
                color: Color(0xFFfeb800),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${donation['notes']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Text(
                            'Amount Requested ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              '${donation['amount']} INR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentTypes(
                        donation: donation,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Donate Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
