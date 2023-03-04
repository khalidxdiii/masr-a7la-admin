import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class AdminLayoutScreenMoudule extends StatelessWidget {
  const AdminLayoutScreenMoudule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        // Sign-out successful.
                      }).catchError((error) {
                        debugPrint(error.ToString());
                      });

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout))
              ],
              title: Center(
                child: Text(
                  cubit.adminTitles[cubit.currentIndex],
                  style: GoogleFonts.almarai(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              leading: const SizedBox(width: 25),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: cubit.adminTitles[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  label: cubit.adminTitles[1],
                )
              ],
            ),
            body: cubit.adminScreens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
