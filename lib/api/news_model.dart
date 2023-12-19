class PostNews {
  List<News> news;
  Sliders sliders;
  List<Category> categories;

  PostNews({
    required this.news,
    required this.sliders,
    required this.categories,
  });

  factory PostNews.fromJson(Map<String, dynamic> json) => PostNews(
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        sliders: Sliders.fromJson(json["sliders"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "sliders": sliders.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  int parentId;
  String title;
  List<dynamic>? children;
  String? slug;

  Category({
    required this.id,
    required this.parentId,
    required this.title,
    this.children,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        title: json["title"],
        children: json["children"] == null
            ? []
            : List<dynamic>.from(json["children"]!.map((x) => x)),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "title": title,
        "children":
            children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
        "slug": slug,
      };
}

class News {
  int id;
  int categoryId;
  String title;
  String img;
  int dateTime;
  String categoryTitle;
  DateTime newsDate;
  Category? category;

  News({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.img,
    required this.dateTime,
    required this.categoryTitle,
    required this.newsDate,
    this.category,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        img: json["img"],
        dateTime: json["date_time"],
        categoryTitle: json["category_title"],
        newsDate: DateTime.parse(json["news_date"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "img": img,
        "date_time": dateTime,
        "category_title": categoryTitle,
        "news_date":
            "${newsDate.year.toString().padLeft(4, '0')}-${newsDate.month.toString().padLeft(2, '0')}-${newsDate.day.toString().padLeft(2, '0')}",
        "category": category?.toJson(),
      };
}

class Sliders {
  List<News> fixed;
  List<News> other;

  Sliders({
    required this.fixed,
    required this.other,
  });

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
        fixed: List<News>.from(json["fixed"].map((x) => News.fromJson(x))),
        other: List<News>.from(json["other"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fixed": List<dynamic>.from(fixed.map((x) => x.toJson())),
        "other": List<dynamic>.from(other.map((x) => x.toJson())),
      };
}





class PostNewsContent {
    List<Post> post;

    PostNewsContent({
        required this.post,
    });

    factory PostNewsContent.fromJson(Map<String, dynamic> json) => PostNewsContent(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
    };
}

class Post {
    int id;
    int categoryId;
    String title;
    String img;
    int dateTime;
    String content;
    String categoryTitle;
    DateTime newsDate;

    Post({
        required this.id,
        required this.categoryId,
        required this.title,
        required this.img,
        required this.dateTime,
        required this.content,
        required this.categoryTitle,
        required this.newsDate,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        img: json["img"],
        dateTime: json["date_time"],
        content: json["content"],
        categoryTitle: json["category_title"],
        newsDate: DateTime.parse(json["news_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "img": img,
        "date_time": dateTime,
        "content": content,
        "category_title": categoryTitle,
        "news_date": "${newsDate.year.toString().padLeft(4, '0')}-${newsDate.month.toString().padLeft(2, '0')}-${newsDate.day.toString().padLeft(2, '0')}",
    };
}



class Search {
  List<News> news;

  Search({
    required this.news,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}
