import 'package:book_library/bloc/book_list_bloc/book_list_bloc.dart';
import 'package:book_library/components/colors.dart';
import 'package:book_library/components/size_config.dart';
import 'package:book_library/helpers/reuse_widget.dart';
import 'package:book_library/models/book_list_mobel.dart';
import 'package:book_library/ui/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BookListBloc bookListBloc;
  bool loading = false;
  int stateStages = 1;
  @override
  void initState() {
    super.initState();
    bookListBloc = BlocProvider.of<BookListBloc>(context);
    print('object');
  }

  List<BookList> bookList = [];
  void toggleIsRead(int index) {
    setState(() {
      bookList[index].isRead = !bookList[index].isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            "The Book Haven",
            style: TextStyle(
              color: COLORS.yellow,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockWidth * 6.6,
              fontFamily: 'Lato',
            ),
          ),
          backgroundColor: COLORS.green.withOpacity(0.7),
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: COLORS.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 2,
                  vertical: SizeConfig.blockHeight * 2),
              alignment: Alignment.center,
              height: SizeConfig.blockHeight * 6,
              child: TextField(
                onChanged: (value) {},
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: COLORS.primary,
                    fontSize: SizeConfig.blockWidth * 3,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato',
                  ),
                  prefixIcon: Icon(Icons.search, color: COLORS.primary),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Find Your Book's",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: COLORS.yellowLight.withOpacity(0.8),
                  fontSize: SizeConfig.blockWidth * 6.6,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Expanded(
              child: BlocListener<BookListBloc, BookListState>(
                listener: (context, state) {
                  if (state is BookListLoading) {
                    stateStages = 1;
                  } else if (state is BookListSuccess) {
                    setState(() {
                      stateStages = 2;
                      bookList = state.bookList;
                    });
                  } else if (state is BookListFailed) {
                    stateStages = 3;
                  }
                  setState(() {});
                },
                child: (stateStages == 1)
                    ? loadingWidget()
                    : (stateStages == 2)
                        ? ListView.builder(
                            itemCount: (bookList.length / 2).ceil(),
                            itemBuilder: (context, index) {
                              final leftIndex = index * 2;
                              final rightIndex = leftIndex + 1;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: leftIndex < bookList.length
                                          ? Container(
                                              height:
                                                  SizeConfig.blockHeight * 40,
                                              child: GestureDetector(
                                                onTap: () {
                                                  toggleIsRead(leftIndex);
                                                },
                                                child: cardContainer(
                                                  title: bookList[leftIndex].title!,
                                                  image:
                                                      "https://covers.openlibrary.org/b/id/${bookList[leftIndex].coverId}-M.jpg",
                                                  txt: bookList[leftIndex].authors[0].name,
                                                  year: bookList[leftIndex].firstPublishYear,
                                                  isRead: bookList[leftIndex].isRead,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                    Expanded(
                                      child: rightIndex < bookList.length
                                          ? Container(
                                              height:
                                                  SizeConfig.blockHeight * 40,
                                              child: GestureDetector(
                                                onTap: () {
                                                  toggleIsRead(rightIndex);
                                                },
                                                child: cardContainer(
                                                  title: bookList[rightIndex]
                                                      .title!,
                                                  image:
                                                      "https://covers.openlibrary.org/b/id/${bookList[rightIndex].coverId}-M.jpg",
                                                  txt: bookList[rightIndex]
                                                      .authors[0]
                                                      .name,
                                                  year: bookList[rightIndex]
                                                      .firstPublishYear,
                                                  isRead: bookList[rightIndex]
                                                      .isRead,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : somethingWentWrong(
                            onPressed: () {
                              bookListBloc.add(const LibraryBookList());
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
