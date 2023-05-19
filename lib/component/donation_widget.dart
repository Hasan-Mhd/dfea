import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class DonationFormWidget extends StatefulWidget {
  @override
  _DonationFormWidgetState createState() => _DonationFormWidgetState();
}

class _DonationFormWidgetState extends State<DonationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  String? _amount;
  String? _notes;
  File? _selectedFile;
  File? _selectedPhoto;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedPhoto = File(result.files.single.path!);
      });
    }
  }

  void _uploadPhoto() async {
    final edocRef = FirebaseFirestore.instance.collection('donations').doc();
    String? documentId;
    if (_selectedPhoto != null) {
      documentId = edocRef.id;
      final fileName = path.basename(_selectedPhoto!.path);
      final storageRef = FirebaseStorage.instance.ref('photos/$documentId');

      try {
        await storageRef.putFile(_selectedPhoto!);
        final photoUrl = await storageRef.getDownloadURL();
        await edocRef.update({'photoUrl': photoUrl});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo uploaded successfully.')),
        );

        // Do something with the photo URL, e.g., save it to Firestore.
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading photo.')),
        );
        print(e);
      }
    }
  }

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    final docRef = FirebaseFirestore.instance.collection('donations').doc();
    String? documentId;

    try {
      await docRef.set({
        'name': _name,
        'email': _email,
        'phone': _phone,
        'address': _address,
        'amount': _amount,
        'notes': _notes,
        'approved': false,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
      documentId = docRef.id;
      if (_selectedFile != null) {
        final ref =
            FirebaseStorage.instance.ref('donations/$documentId/$documentId');
        // path.basename(_selectedFile!.path)
        await ref.putFile(_selectedFile!);
        final url = await ref.getDownloadURL();
        await docRef.update({'documentUrl': url});
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Donation submitted for approval.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting donation.')),
      );
      print(e);
      return;
    }
    if (_selectedPhoto != null) {
      documentId = docRef.id;
      // final fileName = path.basename(_selectedPhoto!.path);
      final storageRef = FirebaseStorage.instance.ref('photos/$documentId');

      try {
        await storageRef.putFile(_selectedPhoto!);
        final photoUrl = await storageRef.getDownloadURL();
        await docRef.update({'photoUrl': photoUrl});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo uploaded successfully.')),
        );

        // Do something with the photo URL, e.g., save it to Firestore.
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading photo.')),
        );
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('choose  photo.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfeb800),
        title: Text('Donation Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email.';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number.';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address.';
                  }
                  return null;
                },
                onSaved: (value) => _address = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount of your donation',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the amount of your donation.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) => _amount = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter any notes you have about your donation',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _notes = value,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
                onPressed: _pickFile,
                child: Text('Upload Document'),
              ),
              if (_selectedFile != null)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Done!',
                      style: TextStyle(color: Colors.greenAccent)),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
                onPressed: _pickPhoto,
                child: Text('Upload photo'),
              ),
              if (_selectedPhoto != null)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Done!',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),
              SizedBox(height: 5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFFfeb800),
                  ),
                ),
                onPressed: _submitForm,
                child: Text('Submit Donation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
