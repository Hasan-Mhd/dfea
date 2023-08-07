import 'package:dfea2/component/donation_widget.dart';
import 'package:flutter/material.dart';

class DonationForm extends StatefulWidget {
  static const String id = 'DonationForm';
  const DonationForm({Key? key}) : super(key: key);

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  @override
  Widget build(BuildContext context) {
    return const DonationFormWidget();
  }
}
