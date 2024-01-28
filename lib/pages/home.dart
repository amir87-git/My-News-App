import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_news/model/art_mod.dart';
import 'package:my_news/model/cat_mod.dart';
import 'package:my_news/model/slider_mod.dart';
import 'package:my_news/pages/all_news.dart';
import 'package:my_news/pages/article_veiw.dart';
import 'package:my_news/pages/category_news.dart';
import 'package:my_news/service/data.dart';
import 'package:my_news/service/news.dart';
import 'package:my_news/service/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CatMod> catergories = [];
  List<sliderModel> sliders = [];
  List<ArtMod> articles = [];
  bool _loading = true;
  
  int activeIndex = 0;
  
  @override
  void initState() {
  catergories = getCategories();
  getSlider();
  getNews();
    super.initState();
  }

  getNews() async{
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async{
    Sliders slider = Sliders();
    await slider.getSlider();
    setState(() {
      sliders = slider.sliders;
      _loading = false;
    }); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("News"), Text("APP", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)],
        ),
        centerTitle: true,
        elevation: 0.0,
        
        ),


      body: _loading
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: catergories.length,
              itemBuilder: (context, index){
                return CategoryTile(
                  image: catergories[index].image,
                  categoryName: catergories[index].categoryName,
                );
              }),
              ),
        
              const SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BREAKING NEWS",
                      style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 18),),


                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Breaking")));
                      },
                      child: const Text(
                        "Veiw All", 
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 132, 253), 
                          fontWeight: FontWeight.w400, 
                          fontSize: 14),),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 20.0,),
              CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realIndex){
              String? res = sliders[index].urlToImage;
              String? res1 = sliders[index].title;
              return buildImage(res!, index, res1!);
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                height: 200,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                )
              ),
              
              const SizedBox(height: 30,),
              Center(child: buildIndicator()),
        
              const SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TRENDING NEWS", 
                      style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 18),),
                    
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Trending")));
                      },
                      child: const Text(
                        "Veiw All", 
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 132, 253), 
                          fontWeight: FontWeight.w400, 
                          fontSize: 14),),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                return BlogTile(
                  url: articles[index].url!,
                  desc: articles[index].description!,
                  imageUrl: articles[index].urlToImage!,
                  title: articles[index].title!,
                  );
              })
              
        
          ],),
        ),
      ),
    );
      
  }

  Widget buildImage(String image, int index, String name) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 250,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,)),

        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 130.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration (color: Colors.black26, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
          child: Text(
            name,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),

        )
    ],),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: const SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),);
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(image, 
            width: 120, 
            height: 60, fit: BoxFit.cover,),
          ),
      
      
          Container(
            width: 120, 
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.black38,),
            
            child: Center(child: Text(categoryName, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
          )
        ],),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtViw(blogUrl: url)));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(imageUrl: imageUrl, height: 150, width: 150, fit: BoxFit.cover,)),
                        
                          const SizedBox(width: 10,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1.9,
                                child: Text(
                                title, maxLines: 2, style: const TextStyle(
                                  color: Color.fromARGB(255, 49, 49, 49), fontWeight: FontWeight.w800, fontSize: 14
                                ),
                                ),
                              ),
                        
                              const SizedBox(width: 8,),
                              Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Text(
                                desc, maxLines: 3, style: const TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 12,
                                ),
                                ),
                              ),
                        
                            ],
                          ),
                        ],),
                      ),
                    ),
                  ),
                ),
              );
  }
}

