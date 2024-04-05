import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/helper/cached_helper.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getUserData(
        id: CachedHelper.getData(
          key: 'uID',
        ),
      );
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                SocialCubit.get(context)
                    .titles[SocialCubit.get(context).currentIndex],
              ),
            ),
            body: SocialCubit.get(context)
                .pages[SocialCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialCubit.get(context).currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 16,
              unselectedFontSize: 14,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(size: 28),
              unselectedIconTheme: const IconThemeData(size: 26),
              onTap: (index) {
                SocialCubit.get(context).changeBotNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
