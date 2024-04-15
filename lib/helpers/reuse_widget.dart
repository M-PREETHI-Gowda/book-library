import 'package:book_library/components/colors.dart';
import 'package:book_library/components/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

actionBar({required BuildContext context}) {
  return AppBar(
    toolbarHeight: 0,
    backgroundColor: COLORS.white,
  );
}

Widget loadingWidget(){
  return Container(
    height: SizeConfig.screenHeight,
    width: SizeConfig.screenWidth,
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
    child: const Center(
      child: CircularProgressIndicator(color: COLORS.yellowLight,)
    ),
  );
}

Widget somethingWentWrong({required VoidCallback onPressed}){
  return Container(
    height: SizeConfig.screenHeight,
    width: SizeConfig.screenWidth,
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Oops!",
          style: TextStyle(
              color: COLORS.yellowLight,
              fontFamily: "NunitoSans",
              fontSize: SizeConfig.blockWidth * 9,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: SizeConfig.blockHeight * 6),
        Text(
          "Something went wrong.\nDont't worry let's try again.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: COLORS.primary,
              fontFamily: "NunitoSans",
              fontSize: SizeConfig.blockWidth * 4.5,
              fontWeight: FontWeight.w500),
        ),

        Container(
          width: SizeConfig.blockWidth * 60,
          height: SizeConfig.blockHeight * 7.2,
          margin: EdgeInsets.only(top: SizeConfig.blockHeight * 4),
          child: ElevatedButton(
            onPressed: (){
              onPressed();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(COLORS.primary),
                foregroundColor: MaterialStateProperty.all<Color>(COLORS.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 6)))),
            child: Text(
              "TRY AGAIN",
              style: TextStyle(
                  color: COLORS.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: "NunitoSans",
                  fontSize: SizeConfig.blockWidth * 4.5),
            ),
          ),
        )
      ],
    ),
  );
}

Widget cardContainer ({required String title, required String image, required String txt, required int year, required bool isRead}) {
  return Container(
    margin: EdgeInsets.only(
        right: SizeConfig.blockWidth * 2,
        left: SizeConfig.blockWidth * 2,
        bottom: SizeConfig.blockHeight * 2),
    decoration: BoxDecoration(
      color: COLORS.white,
      border: Border.all(
        color: COLORS.grey, // Border color
        width: 0.1, // Border width
      ),
      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 2.5)),
      boxShadow: const [
        BoxShadow(
          color: COLORS.grey,
          spreadRadius: 0,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 2.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              height: SizeConfig.blockHeight*60,
              image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 0.5, horizontal: SizeConfig.blockWidth * 2),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: COLORS.black,
                fontSize: SizeConfig.blockWidth * 3.4,
                fontWeight: FontWeight.w900,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric( horizontal: SizeConfig.blockWidth * 2),
            child: Text(
              txt,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: COLORS.primary,
                fontSize: SizeConfig.blockWidth * 3.4,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 0.5, horizontal: SizeConfig.blockWidth * 2),
                child: Text(
                  '$year',
                  style: TextStyle(
                    color: COLORS.yellowLight,
                    fontSize: SizeConfig.blockWidth * 3.4,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 0.5, horizontal: SizeConfig.blockWidth * 2),
                child: Container(
                  width: SizeConfig.blockWidth*20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isRead ? Colors.transparent :COLORS.green,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 5)),
                    color: isRead ? COLORS.green :Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      isRead ? 'Read' : 'Unread',
                      style: TextStyle(
                        color: isRead ? COLORS.white : COLORS.green,
                        fontSize: SizeConfig.blockWidth * 3.4,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHeight*1)
        ],
      ),
    ),
  );
}
