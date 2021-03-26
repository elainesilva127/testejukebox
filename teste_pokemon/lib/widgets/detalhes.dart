import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_pokemon/_model/habilidadesModel.dart';
import 'package:teste_pokemon/_model/pokemonModel.dart';

class Detalhes extends StatelessWidget {
  String urlpokemon;
  String nomepokemon;
  HabilidadespokemonModel habilidadespokemonModel;
  PokemonModel pokemonModel;

  Detalhes(this.nomepokemon, this.urlpokemon);

  mostrarTipo(BuildContext context) 
  { 
      // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Tipo:"),
      content: Text(habilidadespokemonModel.types.toString()),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  mostrarHabilidade(BuildContext context, HabilidadespokemonModel _habilidadespokemonModel) 
  { 
      // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
       },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Habilidades do Pokémon:"),
      elevation: 5,
      content: Text(_habilidadespokemonModel.abilities.toList().toString()),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
  _buscarDetalhesPokemon() async{
    try{
      String url = urlpokemon;
      final response = await Dio().get(url);
      habilidadespokemonModel = HabilidadespokemonModel.fromJson(response.data);
    }catch(Error){
    }
  }


  @override
  Widget build(BuildContext context) {
    _buscarDetalhesPokemon();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text("Detalhes do Pokémon: "+ nomepokemon,
        ),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              RaisedButton(
                elevation: 5,
                color: Colors.orange[600],
                child: Text("Tipo", 
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  mostrarTipo(context);
                },
              ),
              Divider(height: 2,),
              RaisedButton(
                elevation: 5,
                color: Colors.orange[600],
                child: Text("Habilidades", 
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  mostrarHabilidade(context,habilidadespokemonModel);
                },
              ),
          ],
        ),
     )
    );
  }
}