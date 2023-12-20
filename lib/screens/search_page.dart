import 'package:badrnews/Components/news_card.dart';
import 'package:badrnews/api/news_api.dart';
import 'package:badrnews/api/news_model.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchInTitle = "1";
  String searchInText = "1";
  bool checkBoxTitle = true;
  bool checkBoxText = true;
  final controllerSearchNews = TextEditingController();
  final searchFormKey = GlobalKey<FormState>();
  Future<Search>? listNews;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.themeColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            Image.asset(
              './Assets/images/logo-bn.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: searchFormKey,
                    child: TextFormField(
                      controller: controllerSearchNews,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "يرجى ادخال عبارة البحث!";
                        } else if (value.length < 3) {
                          return "يجب أن لا تقل عبارة البحث عن ثلاثة أحرف";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Jazeera-Regular',
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Constants.themeColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Constants.themeColor),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(
                          color: Constants.themeColor,
                          onPressed: () {
                            if (searchFormKey.currentState!.validate()) {
                              if (checkBoxText == false &&
                                  checkBoxTitle == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: const Text(
                                      'يرجى تحديد نطاق البحث',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'Jazeera-Regular',
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
                              } else {
                                debugPrint(controllerSearchNews.text);
                                setState(() {
                                  listNews = fetchSearchItem(
                                    controllerSearchNews.text,
                                    searchInText,
                                    searchInTitle,
                                  );
                                });
                              }
                            }
                          },
                          icon: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                        // icon: Icon(
                        //   Icons.search,
                        // ),
                        // iconColor: Constants.themeColor,
                        hintText: "البحث...",
                        helperText: "",
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Jazeera-Regular',
                        ),
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Jazeera-Regular',
                          color: Constants.iconsColor,
                        ),
                        helperStyle: TextStyle(
                          fontSize: 10,
                          color: Constants.iconsColor,
                          fontFamily: 'Jazeera-Regular',
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(
                          "النص",
                          style: TextStyle(
                            fontFamily: 'Jazeera-Regular',
                            fontSize: 15,
                          ),
                        ),
                        Checkbox(
                          value: checkBoxTitle,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Constants.themeColor.withOpacity(.32);
                            }
                            return Constants.themeColor;
                          }),
                          onChanged: (value) {
                            setState(() {
                              checkBoxTitle = !checkBoxTitle;

                              if (checkBoxTitle == true) {
                                searchInTitle = '1';
                              } else {
                                searchInTitle = '0';
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          "العنوان",
                          style: TextStyle(
                            fontFamily: 'Jazeera-Regular',
                            fontSize: 15,
                          ),
                        ),
                        Checkbox(
                          value: checkBoxText,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Constants.themeColor.withOpacity(.32);
                            }
                            return Constants.themeColor;
                          }),
                          onChanged: (value) {
                            setState(() {
                              checkBoxText = !checkBoxText;
                              if (checkBoxText == true) {
                                searchInText = '1';
                              } else {
                                searchInText = '0';
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),

                //News List
                SizedBox(
                  height: size.height * 0.72,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: size.width - 20,
                    child: FutureBuilderNews(
                      listNews: listNews,
                      searchWord: controllerSearchNews.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FutureBuilderNews extends StatelessWidget {
  final String searchWord;
  const FutureBuilderNews({
    super.key,
    required this.listNews,
    required this.searchWord,
  });

  final Future<Search>? listNews;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listNews,
      builder: (BuildContext context, AsyncSnapshot<Search> snapshot) {
        if (snapshot.hasData && Constants.changeCategory == true) {
          return snapshot.data!.news.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.news.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      dataTime: snapshot.data!.news[index].dateTime.toString(),
                      id: snapshot.data!.news[index].id,
                      image: Constants.imageURLPrefix +
                          snapshot.data!.news[index].img,
                      title: snapshot.data!.news[index].title,
                      sw: searchWord,
                    );
                  },
                )
              : Center(
                  child:
                      Lottie.asset('./Assets/animations/Animation-search.json'),
                );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(
          child: Lottie.asset('./Assets/animations/Animation-search.json'),
        );
      },
    );
  }
}
