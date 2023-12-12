import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeltonNews extends StatefulWidget {
  const SkeltonNews({super.key});

  @override
  State<SkeltonNews> createState() => _SkeltonNewsState();
}

class _SkeltonNewsState extends State<SkeltonNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: SkeletonItem(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(8.0),
                    width: 90,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                      lines: 2,
                      spacing: 12,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 1.1,
                        maxLength: MediaQuery.of(context).size.width / 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkeltonSlider extends StatefulWidget {
  const SkeltonSlider({super.key});

  @override
  State<SkeltonSlider> createState() => _SkeltonSliderState();
}

class _SkeltonSliderState extends State<SkeltonSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SkeletonItem(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: 220.0,
                        minHeight: MediaQuery.of(context).size.height / 4.1,
                        maxHeight: MediaQuery.of(context).size.height / 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkeltonCategory extends StatefulWidget {
  const SkeltonCategory({super.key});

  @override
  State<SkeltonCategory> createState() => _SkeltonCategoryState();
}

class _SkeltonCategoryState extends State<SkeltonCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const SkeletonItem(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      height: 25.0,
                      width: 90,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkeltonNewsContent extends StatefulWidget {
  const SkeltonNewsContent({super.key});

  @override
  State<SkeltonNewsContent> createState() => _SkeltonNewsContentState();
}

class _SkeltonNewsContentState extends State<SkeltonNewsContent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: SkeletonItem(
        child: Column(
          children: <Widget>[
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 250,
                width: size.width,
              ),
            ),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 3,
                spacing: 5,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 14,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 1.1,
                  maxLength: MediaQuery.of(context).size.width / 1,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      height: 40.0,
                      width: size.width * 0.3,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 12,
                  spacing: 16,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 14,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 1.1,
                    maxLength: MediaQuery.of(context).size.width / 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
