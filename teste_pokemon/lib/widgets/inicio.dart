import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teste_pokemon/_model/pokemonModel.dart';
import 'package:teste_pokemon/widgets/detalhes.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  PokemonModel pokemonModel;

  String _nomePokemon;
  String _urlPokemon = 'https://i.pinimg.com/originals/ae/48/a8/ae48a8a297e2cfc33d381f39e22cfdba.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarPokemon();
  }
  _recuperarPokemon() async{
    try{
      String url = "https://pokeapi.co/api/v2/pokemon?limit=5&offset=200";
      final response = await Dio().get(url);
      pokemonModel = PokemonModel.fromJson(response.data);
      setState(() {
        //_nomePokemon = responseMap["name"].toString();
      });
     
    }catch(Error){
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        title: Text ("Lista de Pokémons",
        style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: pokemonModel.results.map((pokemon) => Padding(
          padding: EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detalhes(
                pokemon.name,pokemon.url
              )));
            },
            child: Card(
            
            elevation: 10,
            child: Column(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                    ),
                  ),
                )
              ]
            ),
          ),
          )

        )).toList(),
        ),
        
    );
  }
}