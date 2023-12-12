import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/news_content.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NewsCard extends StatefulWidget {
  final String image;
  final String title;
  final int dataTime;
  final int id;
  const NewsCard({
    super.key,
    required this.image,
    required this.title,
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    child: Text(
                      widget.title,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Jazeera-Bold',
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
