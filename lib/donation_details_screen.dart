import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/donation_types_screen.dart';
import 'package:dfea2/profile_screen.dart';
import 'package:flutter/material.dart';

import 'component/payment_screen.dart';

class DonationDetailsScreen extends StatefulWidget {
  late QueryDocumentSnapshot<Object?> donation;

  DonationDetailsScreen({required this.donation});

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  late int amountDonated;
  @override
  void initState() {
    amountDonated = widget.donation['amountDonated'];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: '${widget.donation['userId']}',
                child: Container(
                  height: 250,
                  child: Image(
                    image: NetworkImage(
                      widget.donation['photoUrl'],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('${widget.donation['name']}'),
              Card(
                color: Color(0xFFfeb800),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Container(
                    width: 250,
                    height: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${widget.donation['notes']}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                              '${widget.donation['amount']} INR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Amount Donated :$amountDonated ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                        donation: widget.donation,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: Text(
                  'Chick your profile',
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
