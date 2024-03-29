import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfea2/component/pdf_viewer_method.dart';
import 'package:dfea2/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class AdminScreen extends StatefulWidget {
  static const String id = 'AdminScreen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Future<String?> getDocumentUrl(String documentId) async {
    final ref =
        FirebaseStorage.instance.ref('donations/$documentId/$documentId');
    final url = await ref.getDownloadURL();
    return url;
  }

  Future<String?> getPhotoUrl(String documentId) async {
    final ref = FirebaseStorage.instance.ref('photos/$documentId');
    final url = await ref.getDownloadURL();
    return url;
  }

  void _approveDonation(DocumentSnapshot donation) {
    donation.reference.update({'approved': true});
  }

  void _disapproveDonation(DocumentSnapshot donation) {
    donation.reference.delete();
  }

  Future<void> downloadDocument(String documentUrl, String documentName) async {
    final response = await http.get(Uri.parse(documentUrl));
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDirectory.path}/$documentName');
    await file.writeAsBytes(response.bodyBytes);
  }

  Future<void> openDocument(BuildContext context, String documentName) async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentsDirectory.path}/$documentName';

    try {
      final fileExists = await File(filePath).exists();
      if (fileExists) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFView(
              filePath: filePath,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document not found. Please download it first.'),
          ),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening the document: ${e.message}'),
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Requests'),
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: const Icon(Icons.arrow_back))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('approved', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final donations = snapshot.data!.docs;

          if (donations.isEmpty) {
            return const Center(
              child: Text('No donations to approve'),
            );
          }

          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (BuildContext context, int index) {
              final donation = donations[index];
              final documentId = donation.id;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 180,
                          width: 180,
                          child: FutureBuilder<String?>(
                            future: getPhotoUrl(documentId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  imageUrl: snapshot.data!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                );
                              } else {
                                return Container(
                                  child: const Text('No data'),
                                ); // or any other default widget
                              }
                            },
                          ),
                        ),
                      ),
                      Text(
                        'Name: ${donation['name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Email: ${donation['email']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Address: ${donation['address']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Amount: ${donation['amount']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => _approveDonation(donation),
                            icon: const Icon(Icons.check),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () => _disapproveDonation(donation),
                            icon: const Icon(Icons.close),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: () async {
                              final documentUrl =
                                  await getDocumentUrl(documentId);

                              if (documentUrl != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerMethod(
                                      pdfUrl: documentUrl,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.attachment),
                            color: Colors.blue,
                          ),
                          // IconButton(
                          //   onPressed: () async {
                          //     final documentUrl =
                          //         await getDocumentUrl(documentId);
                          //
                          //     if (documentUrl != null) {
                          //       final documentName =
                          //           documentUrl.split('/').last;
                          //       await downloadDocument(
                          //           documentUrl, documentName);
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text(
                          //               'Document downloaded successfully'),
                          //         ),
                          //       );
                          //
                          //       openDocument(context,
                          //           documentName); // Open the downloaded document
                          //     }
                          //   },
                          //   icon: Icon(Icons.download),
                          //   color: Colors.orange,
                          // ),
                        ],
                      ),
                    ],
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
