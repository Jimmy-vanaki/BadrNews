import 'package:badrnews/Components/skeleton.dart';
import 'package:badrnews/Components/webview_content.dart';
import 'package:badrnews/api/news_api.dart';
import 'package:badrnews/api/news_model.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class NewsContent extends StatefulWidget {
  final int newsId;
  const NewsContent({
    super.key,
    required this.newsId,
  });

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  bool addToFavorite = false;
  Future<PostNewsContent>? newsContent;

  @override
  void initState() {
    newsContent = fetchNewsContent(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: newsContent,
        builder:
            (BuildContext context, AsyncSnapshot<PostNewsContent> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    Constants.imageURLPrefix + snapshot.data!.post[0].img,
                    height: 300,
                    width: size.width,
                    fit: BoxFit.fill,
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.7,
                    minChildSize: 0.7,
                    maxChildSize: 0.89,
                    snap: true,
                    snapAnimationDuration: const Duration(milliseconds: 400),
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Constants.themeColor,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    snapshot.data!.post[0].title,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: Constants.fontSize,
                                      fontFamily: 'Jazeera-Bold',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.share_outlined,
                                      color: Constants.themeColor,
                                      size: 25,
                                    ),
                                    Text(
                                      snapshot.data!.post[0].dateTime
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Jazeera-Regular',
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                LoadContentWebView(
                                  content: snapshot.data!.post[0].content,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(
                                context,
                              );
                            });
                          },
                          child: const BlurryContainer(
                            blur: 2,
                            width: 40,
                            height: 40,
                            elevation: 0,
                            color: Colors.white30,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              addToFavorite = !addToFavorite;
                            });
                          },
                          child: BlurryContainer(
                            blur: 2,
                            width: 40,
                            height: 40,
                            elevation: 0,
                            color: Colors.white30,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Icon(
                              addToFavorite
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: addToFavorite
                                  ? Constants.themeColor
                                  : Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return const Directionality(
            textDirection: TextDirection.rtl,
            child: SkeltonNewsContent(),
          );
        },
      ),
    );
  }
}
