import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/problem_model.dart';
import '../../models/user_model.dart';
import '../../shared/component/componant.dart';
import 'report details/report_details_screen.dart';
import 'report_card_item.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var refReport =
        FirebaseFirestore.instance.collection('problems').orderBy('timestamp');

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
        stream: refReport.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Loading');
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // final problemModel = MAProblemModel.fromJSON(
                //     snapshot.data!.docs[index].data() as Map,
                //     snapshot.data!.docs[index].id);
                final problemModel = MAProblemModel.fromJSON(
                  snapshot.data!.docs[index].data() as Map,
                );

                return FutureBuilder(
                  future: (FirebaseFirestore.instance
                      .collection('users')
                      .doc(problemModel.uID)
                      .get()),
                  builder: (context, fusnap) {
                    if (fusnap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (fusnap.hasData) {
                      final user =
                          MAUserModel.fromJSON(fusnap.data?.data() as Map);
                      // return reportcard(problemModel, user, context);
                      return ReportCardItem(
                        problemModel: problemModel,
                        userModel: user,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
