import 'package:flutter/material.dart';
import 'package:new_app/widgets/error_message.dart';
import 'package:new_app/widgets/format_date.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier {
  String newId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  NewsModel({
    required this.newId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.dateToShow,
    required this.content,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(dynamic json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    String content = json['content'] ?? '';
    String dateToShow = '';
    if (json['publishedAt'] != null) {
      dateToShow = FormattedDate.formattedDateText(json['publishedAt']);
    }
    return NewsModel(
      newId: json['source']['id'] ?? '',
      sourceName: json['source']['name'] ?? '',
      authorName: json['author'] ?? '',
      title: title,
      description: description,
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: dateToShow,
      content: content,
      // readingTimeText: 'readingTimeText',
      readingTimeText: readingTime(title + description + content).msg,
    );
  }

  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['NewId'] = newId;
    data['sourceName'] = sourceName;
    data['authorName'] = authorName;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['dateToShow'] = dateToShow;
    data['content'] = content;
    data['readingTimeText'] = readingTimeText;
    return data;
  }

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return 'news {newid: $newId}';
  // }
}
