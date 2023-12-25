import 'package:badrnews/Components/news_card.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/db/badr_database.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Constants.connectToInternet
        ? FutureBuilder(
            future: getBookMark(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Constants.bookMarkContent.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: size.width - 20,
                        height: size.height,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: Constants.bookMarkContent.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              image: Constants.bookMarkContent[index]['image'],
                              title: Constants.bookMarkContent[index]['title'],
                              sw: '',
                              dataTime: Constants.bookMarkContent[index]
                                  ['data'],
                              id: Constants.bookMarkContent[index]['id'],
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Lottie.asset(
                        './Assets/animations/Animation-bookmark.json',
                        width: 200,
                      ),
                    );
            },
          )
        : Center(
            child: Lottie.asset(
              './Assets/animations/Animation-network.json',
              width: 200,
            ),
          );
  }
}
