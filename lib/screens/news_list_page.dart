import 'package:badrnews/Components/news_card.dart';
import 'package:badrnews/Components/skeleton.dart';
import 'package:badrnews/api/news_api.dart';
import 'package:badrnews/api/news_model.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/news_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NewsListPag extends StatefulWidget {
  const NewsListPag({super.key});

  @override
  State<NewsListPag> createState() => _NewsListPagState();
}

final CarouselController _CarouselController = CarouselController();

class _NewsListPagState extends State<NewsListPag> {
  int _current = 0;
  int selectedCategory = 0;
  Future<PostNews>? listNews;
  static const List<String> sampleImages = [
    './Assets/images/d-s001.jpg',
    './Assets/images/d-s002.jpg',
    './Assets/images/d-s003.jpg',
    './Assets/images/d-s004.jpg',
  ];

  @override
  void initState() {
    listNews = fetchNews(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "احدث الاخبار",
                      style: TextStyle(
                        fontFamily: 'Jazeera-Bold',
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 30,
                    )
                  ],
                ),
              ),
              // Slider News
              Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 220.0,
                      autoPlay: true,
                      disableCenter: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    items: [0, 1, 2, 3].map((i) {
                      return FutureBuilder(
                        future: listNews,
                        builder: (BuildContext context,
                            AsyncSnapshot<PostNews> snapshot) {
                          if (snapshot.hasData &&
                              Constants.changeCategory == true) {
                            return i == 0
                                ? SliderItem(
                                    id: snapshot.data!.sliders.fixed[i].id,
                                    image: Constants.imageURLPrefix +
                                        snapshot.data!.sliders.fixed[i].img,
                                    title:
                                        snapshot.data!.sliders.fixed[i].title,
                                  )
                                : SliderItem(
                                    id: snapshot.data!.sliders.other[i].id,
                                    image: Constants.imageURLPrefix +
                                        snapshot.data!.sliders.other[i].img,
                                    title:
                                        snapshot.data!.sliders.other[i].title,
                                  );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          }
                          return const SkeltonSlider();
                        },
                      );
                    }).toList(),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sampleImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _CarouselController.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Constants.themeColor).withOpacity(
                                  _current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              // CATEGORY
              SizedBox(
                height: 30,
                width: size.width,
                child: FutureBuilder(
                  future: listNews,
                  builder:
                      (BuildContext context, AsyncSnapshot<PostNews> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.categories.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                Constants.changeCategory = false;
                                listNews = fetchNews(
                                    snapshot.data!.categories[index].id);
                                selectedCategory = index;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: selectedCategory == index
                                          ? Constants.themeColor
                                          : Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  snapshot.data!.categories[index].title,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'Jazeera-Regular',
                                    fontSize: 17,
                                    fontWeight: selectedCategory == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: selectedCategory == index
                                        ? Constants.themeColor
                                        : Constants.itemColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    }
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const SkeltonCategory();
                      },
                    );
                  },
                ),
              ),

              //News List
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: size.width - 20,
                child: FutureBuilderNews(listNews: listNews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FutureBuilderNews extends StatelessWidget {
  const FutureBuilderNews({
    super.key,
    required this.listNews,
  });

  final Future<PostNews>? listNews;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listNews,
      builder: (BuildContext context, AsyncSnapshot<PostNews> snapshot) {
        if (snapshot.hasData && Constants.changeCategory == true) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.news.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return NewsCard(
                dataTime: snapshot.data!.news[index].dateTime,
                id: snapshot.data!.news[index].id,
                image:
                    Constants.imageURLPrefix + snapshot.data!.news[index].img,
                title: snapshot.data!.news[index].title,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const SkeltonNews();
          },
        );
      },
    );
  }
}

class SliderItem extends StatelessWidget {
  final String image;
  final String title;
  final int id;

  const SliderItem({
    super.key,
    required this.image,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: NewsContent(
              newsId: id,
            ),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Stack(
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              width: size.width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Image.network(
                image,
                height: 220,
                fit: BoxFit.fill,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: child,
                  );
                },
              ),
            ),
            Positioned(
              top: 60,
              right: 0,
              left: 0,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Constants.themeColor],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 90,
                    right: 10,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Jazeera-Regular',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
