import 'package:flutter/material.dart';

void main() {
  runApp(MyApp3());
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

class MyApp3 extends StatelessWidget {
  final Movie movie = Movie(
    title: 'Spider-Man No Way Home',
    director: 'Jon Watts',
    releaseDate: '13 de diciembre de 2021',
    description:
        'es una película estadounidense de superhéroes basada en el personaje Spider-Man, de Marvel Comics, coproducida por Columbia Pictures y Marvel Studios, y distribuida por Sony Pictures Releasing. Es la secuela de Spider-Man: Homecoming (2017) y Spider-Man: Lejos de casa (2019), y la película número 27 en el Universo cinematográfico de Marvel (UCM). La película está dirigida por Jon Watts, escrita por Chris McKenna y Erik Sommers, y protagonizada por Tom Holland como Peter Parker/Spider-Man, junto a un elenco conformado por Zendaya, Benedict Cumberbatch, Jacob Batalon, Jon Favreau, Jamie Foxx, Willem Dafoe, Alfred Molina, Benedict Wong, Tony Revolori, Marisa Tomei, Andrew Garfield y Tobey Maguire. En la película, Peter Parker le pide al Dr. Stephen Strange (Cumberbatch) que lo ayude a hacer de su identidad como Spider-Man un secreto después de su revelación pública, lo que lleva a la ruptura del multiverso al permitir que cinco supervillanos de realidades alternativas ingresen al universo de Peter Parker.',
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
                'assets/images/spiderman1.jpeg', 
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
