import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:mangas_siferlu/src/models/manga.models.dart';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class MangasProviders {
  final String _url = 'https://dbflutter-e6764.firebaseio.com';

  Future<bool> crearManga(MangaModel manga) async {
    final url = '$_url/mangas.json';

    final resp = await http.post(url,body: mangaModelToJson(manga) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarManga(MangaModel manga) async {
    final url = '$_url/mangas/${manga.id}.json';

    final resp = await http.put(url,body: mangaModelToJson(manga) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<MangaModel>> cargarManga() async{
    final url='$_url/mangas.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<MangaModel> mangas = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, clien){
      final banTemp = MangaModel.fromJson(clien);
      banTemp.id=id;

      mangas.add(banTemp);
    });
    print(mangas);

    return mangas;
  }

  //BORRAR CAMPOS

  Future<int> borrarManga(String id) async {

    final url ='$_url/mangas/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/drdntpcar/image/upload?upload_preset=xhzk5zrh');
   final mimeType = mime(imagen.path).split('/');

   final imageUploadRequest = http.MultipartRequest(
     'POST',
     url
   );

   final file = await http.MultipartFile.fromPath(
     'file', 
     imagen.path,
     contentType: MediaType( mimeType[0], mimeType[1])
     );

     imageUploadRequest.files.add(file);

     final streamResponse = await imageUploadRequest.send();
     final resp = await http.Response.fromStream(streamResponse);
     if(resp.statusCode != 200 && resp.statusCode != 201){
       print('Algo salio mal');
       print(resp.body);
       return null;
     }
     final respData = json.decode(resp.body);
     print(respData);
     return respData['secure_url'];
  }

}
