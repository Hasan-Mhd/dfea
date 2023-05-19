import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const String id = 'TransactionHistoryScreen';

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('payments')
            .where('userId', isEqualTo: _user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transactions = snapshot.data!.docs;
            if (transactions.isEmpty) {
              return Center(
                child: Text('No transactions found.'),
              );
            } else {
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final amount = transaction['amount'];
                  final date = transaction['timestamp']?.toDate();
                  return ListTile(
                    title: Text('Amount: $amount'),
                    subtitle: Text('Date: $date'),
                  );
                },
              );
            }
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred while fetching transactions.'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
