import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'donation_details_screen.dart';

class DonationMainScreen extends StatefulWidget {
  static const String id = 'DonationMainScreen';
  const DonationMainScreen({Key? key}) : super(key: key);

  @override
  State<DonationMainScreen> createState() => _DonationMainScreenState();
}

class _DonationMainScreenState extends State<DonationMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('approved', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            print("empty");
            return Center(child: Text('No donations yet'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final donation = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDetailsScreen(
                        donation: donation,
                      ),
                    ),
                  );
                },
                child: Card(
                  surfaceTintColor: Color(0xFFfeb800),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Center(child: Text(donation['name'])),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 180,
                              height: 180,
                              child: Hero(
                                tag: '${donation['name']}',
                                child: Image(
                                    image: NetworkImage(donation['photoUrl'])),
                              )),
                        ),
                        Text('${donation['amount']} INR'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('${donation['email']} '),
                        // Text(donation['date'].toDate().toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
