import 'dart:async';
import 'package:book_library/bloc/book_list_bloc/book_list_bloc.dart';
import 'package:book_library/components/colors.dart';
import 'package:book_library/components/size_config.dart';
import 'package:book_library/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlocProvider(
          create: (context) => BookListBloc()..add(const LibraryBookList()),
          child: HomeScreen(),
        ))));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: COLORS.white,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(
          children: [
            Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover)),
            Positioned(
              top: SizeConfig.blockHeight * 50,
              left: SizeConfig.blockWidth * 5,
              right: SizeConfig.blockWidth * 5,
              child: Text(
                "The Book Haven",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: COLORS.yellow,
                  fontFamily: "lato",
                  fontSize: SizeConfig.blockWidth * 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
