import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/component/componant.dart';
import '../open image/open_image.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key, this.problem, this.user});
  final MAProblemModel? problem;
  final MAUserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
        title: Center(
          child: Text(
            'تفاصيل التقرير',
            style: GoogleFonts.almarai(),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '    بيانات المستخدم',
                    style: GoogleFonts.almarai(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ),
                reportCardDetailsWidget(
                    text: user!.fullName!,
                    icon: Icons.person_outline,
                    fontWeight: FontWeight.bold),
                reportCardDetailsWidget(
                    text: user!.phone!, icon: Icons.phone_iphone_outlined),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '    بيانات التقرير',
                    style: GoogleFonts.almarai(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                ),
                reportCardDetailsWidget(
                    text: 'رقم التقرير : ${problem!.report_id!}',
                    icon: Icons.list_alt),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OpenImageScreen(
                          imageUrl: problem,
                        );
                      }));
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: reportDetailsImageCard(
                        imageUrl: problem!.imageUrl!,
                      ),
                    )),
                reportCardDetailsWidget(
                    text: problem!.title!, icon: Icons.list_alt),
                reportCardDetailsWidget(
                    text: problem!.locationDisc!, icon: Icons.explore_outlined),
                reportCardDetailsWidget(
                    text: problem!.prTime!, icon: Icons.calendar_month),
                reportCardDetailsWidget(
                    text: problem!.disc!, icon: Icons.description_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
