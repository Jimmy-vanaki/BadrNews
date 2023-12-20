import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/news_content.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:substring_highlight/substring_highlight.dart';

class NewsCard extends StatefulWidget {
  final String image;
  final String title;
  final String sw;
  final String dataTime;
  final int id;
  const NewsCard({
    super.key,
    required this.image,
    required this.title,
    required this.sw,
    required this.dataTime,
    required this.id,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint(widget.id.toString());
        Navigator.push(
          context,
          PageTransition(
            child: NewsContent(
              newsId: widget.id,
            ),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.image,
                  width: 90,
                  height: 80,
                  fit: BoxFit.fill,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return Container(
                      width: 90,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Constants.themeColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: SubstringHighlight(
                        text: widget.title,
                        term: widget.sw,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Jazeera-Bold',
                          color: Colors.black87,
                        ),
                        textStyleHighlight: TextStyle(
                          backgroundColor: Colors.yellow,
                          color: Constants.themeColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.dataTime.toString(),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'Jazeera-Regular',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
