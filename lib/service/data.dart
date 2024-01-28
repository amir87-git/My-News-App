import 'package:my_news/model/cat_mod.dart';


List<CatMod> getCategories() {
  List<CatMod> category =[];
  CatMod catMod = new CatMod();

  catMod.categoryName = "Business";
  catMod.image = "asset/image/h.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Entertainment";
  catMod.image = "asset/image/E.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "General";
  catMod.image = "asset/image/G.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Health";
  catMod.image = "asset/image/L.jpg";
  category.add(catMod);
  catMod = new CatMod();

  catMod.categoryName = "Sports";
  catMod.image = "asset/image/S.jpg";
  category.add(catMod);
  catMod = new CatMod();

  return category;
}