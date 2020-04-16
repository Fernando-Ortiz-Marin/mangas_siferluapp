import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangas_siferlu/src/models/usuario.models.dart';

class UsuariosProviders {
  final String _url = 'https://dbflutter-e6764.firebaseio.com';

  Future<bool> crearUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuarios.json';

    final resp = await http.post(url,body: usuarioModelToJson(usuario) );

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }

Future<bool> editarUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuarios/${usuario.id}.json';

    final resp = await http.put(url,body: usuarioModelToJson(usuario) );
  

    final decodedData=json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future <List<UsuarioModel>> cargarUsuario() async{
    final url='$_url/usuarios.json';
    final resp=await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<UsuarioModel> usuarios = new List();

    if (decodeData == null )return[];
    
    decodeData.forEach((id, clien){
      final clienTemp = UsuarioModel.fromJson(clien);
      clienTemp.id=id;

      usuarios.add(clienTemp);
    });
    print(usuarios);

    return usuarios;
  }

  //BORRAR CAMPOS

  Future<int> borrarUsuario(String id) async {

    final url ='$_url/usuarios/$id.json';
    final resp= await http.delete(url);

    print(resp.body);

    return 1;
  }
}
