import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/donation_types_screen.dart';
import 'package:dfea2/profile_screen.dart';
import 'package:flutter/material.dart';


class DonationDetailsScreen extends StatefulWidget {
  late QueryDocumentSnapshot<Object?> donation;

  DonationDetailsScreen({super.key, required this.donation});

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
                child: SizedBox(
                  height: 250,
                  child: Image(
                    image: NetworkImage(
                      widget.donation['photoUrl'],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text('${widget.donation['name']}'),
              Card(
                color: const Color(0xFFfeb800),
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${widget.donation['notes']}',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const Text(
                            'Amount Requested ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              '${widget.donation['amount']} INR',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Amount Donated :$amountDonated ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
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
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
                child: const Text(
                  'Donate Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
                child: const Text(
                  'Chick your profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
