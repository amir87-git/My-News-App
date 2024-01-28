import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_news/model/show_category.dart';
import 'package:my_news/pages/article_veiw.dart';
import 'package:my_news/service/show_cat_news.dart';

class CategoryNews extends StatefulWidget {
  final name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ShowCatMod> categories = [];
  

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async{
    ShowCatNews showCatNews = ShowCatNews();
    await showCatNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCatNews.categories;
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
        
         Text(widget.name, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        
        centerTitle: true,
        elevation: 0.0,
        ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ShowCategory(
              url: categories[index].url!,
              desc: categories[index].description!,
              Image: categories[index].urlToImage!,
              title: categories[index].title!);
          }),
      )
    );
  }
}

class ShowCategory extends StatelessWidget {
  final Image, desc, title, url;
  ShowCategory ({required this.Image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtViw(blogUrl: url)));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: Image,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,),
          ),
            
          const SizedBox(height: 5,),
          Text(title,
          maxLines: 2,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
            
          Text(desc,
          maxLines: 3,
          style: const TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.normal),),
            
          const SizedBox(height: 20,),
            
        ],
      ),
    );
  }
}