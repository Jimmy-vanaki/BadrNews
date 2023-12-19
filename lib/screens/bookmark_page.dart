import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';


class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: size.width - 20,
        height: size.height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: Constants.bookMarkList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const Text("ewqewq");
          },
        ),
      ),
    );
  }
}
