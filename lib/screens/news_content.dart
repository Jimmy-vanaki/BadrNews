import 'package:badrnews/Components/skeleton.dart';
import 'package:badrnews/Components/webview_content.dart';
import 'package:badrnews/api/news_api.dart';
import 'package:badrnews/api/news_model.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/db/badr_database.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class NewsContent extends StatefulWidget {
  final int newsId;
  final String sw;
  const NewsContent({
    super.key,
    required this.newsId,
    required this.sw,
  });

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
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
                                      fontSize: Constants.fontSize + 4,
                                      fontFamily: Constants.boldFontFamily,
                                      color: Constants.themeColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        debugPrint("qwewqeqw");
                                        // Share.share("text");
                                        final box = context.findRenderObject()
                                            as RenderBox?;
                                        String shareNews;
                                        shareNews =
                                            '${Constants.shareAppText}\n${snapshot.data!.post[0].title}\n${snapshot.data!.post[0].content}';
                                        shareNews =
                                            removeAllHtmlTags(shareNews);
                                        shareNews =
                                            shareNews.replaceAll('&nbsp;', '');
                                        Share.share(
                                          shareNews,
                                          subject: '',
                                          sharePositionOrigin:
                                              box!.localToGlobal(Offset.zero) &
                                                  box.size,
                                        );
                                      },
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: Constants.themeColor,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.post[0].newsDate
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                              Constants.regularFontFamily,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                LoadContentWebView(
                                  content: snapshot.data!.post[0].content,
                                  sw: widget.sw,
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
                        //BACK _
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
                        //BOOK MARK
                        FutureBuilder(
                          future: hasBookMark(widget.newsId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot11) {
                            // addToFavorite = Constants.hasbookmark;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  Constants.hasbookmark =
                                      !Constants.hasbookmark;
                                });
                                if (Constants.hasbookmark == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: const Text(
                                        'تمت الاضافة للمفضلة',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily:
                                              Constants.regularFontFamily,
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Constants.themeColor,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 30,
                                      ),
                                    ),
                                  );

                                  addToBookMark(
                                    widget.newsId,
                                    snapshot.data!.post[0].title,
                                    snapshot.data!.post[0].newsDate.toString(),
                                    Constants.sliderImageURLPrefix +
                                        snapshot.data!.post[0].img,
                                    snapshot.data!.post[0].content,
                                  );
                                } else {
                                  // bookMarkList.removeLast();
                                  deleteBookmark(widget.newsId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: const Text(
                                        'تم الحذف من المفضلة',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontFamily:
                                              Constants.regularFontFamily,
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Constants.themeColor,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 30,
                                      ),
                                    ),
                                  );
                                }
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
                                  Constants.hasbookmark
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Constants.hasbookmark
                                      ? Constants.themeColor
                                      : Colors.black,
                                  size: 25,
                                ),
                              ),
                            );
                          },
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
