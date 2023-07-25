import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  List pokedex = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        pokedex.length != null
            ? Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text(
                            pokedex[index]['name'],
                          ),
                          CachedNetworkImage(imageUrl: pokedex[index]['img']),
                        ],
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ],
    ));
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodeJsonData = jsonDecode(value.body);
        pokedex = decodeJsonData['pokemon'];
        setState(() {});
      }
    });
  }
}
