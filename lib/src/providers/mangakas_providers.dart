import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangas_siferlu/src/models/mangaka.models.dart';

class MangakasProviders {
  final String _url = 'https://dbflutter-e6764.firebaseio.com';

  Future<bool> crearMangaka(MangakaModel mangaka) async {
    final url = '$_url/mangakas.json';

    final resp = await http.post(url,body: mangakaModelToJson(mangaka) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarMangaka(MangakaModel mangaka) async {
    final url = '$_url/mangakas/${mangaka.id}.json';

    final resp = await http.put(url,body: mangakaModelToJson(mangaka) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<MangakaModel>> cargarMangaka() async{
    final url='$_url/mangakas.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<MangakaModel> mangakas = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, lug){
      final lugTemp = MangakaModel.fromJson(lug);
      lugTemp.id=id;

      mangakas.add(lugTemp);
    });
    print(mangakas);

    return mangakas;
  }

  //BORRAR CAMPOS

  Future<int> borrarMangaka(String id) async {

    final url ='$_url/mangakas/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
}
