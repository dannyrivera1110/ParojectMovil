
import 'package:flutter/material.dart';

class MapItemDetails extends StatefulWidget {
final String cineNombre;
  const MapItemDetails({super.key,  required this.cineNombre,} );

  @override
  State<MapItemDetails> createState() => _MapItemDetailsState();
}

class _MapItemDetailsState extends State<MapItemDetails> {
  String get cineNombre => cineNombre;

 
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(15.0),
    child: Card(
      
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        children: [Expanded(child: Image.asset("assets/images/marker2.png" ), ), Expanded(child: Column(children: [Text(cineNombre), Text("Welcome to Cine")],))],
      ),
    ),
    
    );
  }
}