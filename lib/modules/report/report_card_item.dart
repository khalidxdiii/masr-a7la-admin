import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/problem_model.dart';
import '../../models/user_model.dart';
import '../../shared/component/componant.dart';
import 'report details/report_details_screen.dart';

class ReportCardItem extends StatelessWidget {
  const ReportCardItem({
    super.key,
    required this.problemModel,
    required this.userModel,
  });
  final MAProblemModel problemModel;
  final MAUserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 2, top: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.teal,
            width: 2.0,
          ),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 15), blurRadius: 25, color: Colors.black12),
          ],
        ),
        //width: 420,
        height: 240,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     height: 120,
              //     margin: const EdgeInsets.only(
              //         top: 20, bottom: 20, left: 10, right: 0),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       border: Border.all(
              //         color: Colors.teal,
              //         width: 2.0,
              //       ),
              //       //color: Colors.red,
              //     ),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(15),
              //       child: Image.network(
              //         '${snapshot.data!.docs[index]["image_url"]}',
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.teal,
                                radius: 20,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                userModel.fullName ?? 'no name',
                                //'${userData['full name']}',
                                // fullname!,

                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.almarai(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 5,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      problemModel.title!,
                                      //'عنوان التقرير',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "رقم التقرير : ${problemModel.report_id!}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      problemModel.disc!,
                                      //'',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      problemModel.prTime!,
                                      //'العنوان : القاهره',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: DefaultButton(
                                text: 'التفاصيل',
                                // function: () async {
                                //   DocumentSnapshot userDoc = await FirebaseFirestore
                                //       .instance
                                //       .collection('users')
                                //       .doc(
                                //           '${snapshot.data!.docs[index]['user_id']}')
                                //       .get();
                                //   Map<String, dynamic> userData =
                                //       userDoc.data() as Map<String, dynamic>;
                                //   debugPrint('${userData['full name']}');
                                // },
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReportDetailsScreen(
                                        user: userModel,
                                        problem: problemModel,
                                      ),
                                    ),
                                  );
                                },
                                width: 100,
                                radius: 10,
                                height: 30),
                          ),
                        ]),
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
