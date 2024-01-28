import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:my_news/model/art_mod.dart';

class News{
  List<ArtMod> news = [];

  Future<void> getNews() async{
    
    String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6c094aebf12b4dab9e472576c32ab964";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArtMod artMod = ArtMod(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],  
          );
          news.add(artMod);
        }
      });
    }
  }
}