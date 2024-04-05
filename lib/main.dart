import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/bloc_observer.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/helper/cached_helper.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/pages/login_page.dart';

String? uID;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CachedHelper.init();
  Widget widget;
  uID = CachedHelper.getData(
    key: 'uID',
  );
  if (uID != null) {
    widget = const HomeLayout();
  } else {
    widget = const LoginPage();
  }
  runApp(SocialApp(
    startWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  final Widget startWidget;
  const SocialApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
