import 'package:flutter/material.dart';

void main() {
  runApp(MyApp2());
}

class Movie {
  final String title;
  final String director;
  final String releaseDate;
  final String description;

  Movie({
    required this.title,
    required this.director,
    required this.releaseDate,
    required this.description,
  });
}

class MyApp2 extends StatelessWidget {
  final Movie movie = Movie(
    title: 'John Wick 4',
    director: 'Chad Stahelski',
    releaseDate: '24 de marzo de 2023',
    description:
              'El marqués Vincent de Gramont pretende matar a John Wick para afianzar su poder en la Orden Suprema. Sin embargo, John tratará de adelantarse a cada uno de sus movimientos hasta lograr enfrentarse cara a cara con su peor enemigo.'

          );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detalles de la película'),
        ),
        body: MovieDetailsScreen(movie: movie),
      ),
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                'assets/images/johnwick.jpeg', 
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // Acción al hacer clic en el botón de cerrar
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Director: ${movie.director}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Fecha de lanzamiento: ${movie.releaseDate}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Descripción:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            movie.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
