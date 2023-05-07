import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationMainScreen extends StatelessWidget {
  static const String id = 'DonationMainScreen';
  const DonationMainScreen({Key? key}) : super(key: key);

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
            print(snapshot);
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            print("empty");
            return Center(child: Text('No donations yet'));
          }
          print(snapshot);
          print("*********$data");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final donation = data[index];
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DonationDetailsScreen(donation: donation),
                  //   ),
                  // );
                },
                child: Card(
                  child: ListTile(
                    title: Text(donation['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${donation['amount']} EGP'),
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
