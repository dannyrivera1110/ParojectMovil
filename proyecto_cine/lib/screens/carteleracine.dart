import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Movie {
  final String title;
  final String director;
  final String imageUrl;
  final String description;
  final String horario;
  bool isFavorite;
  String review;

  Movie({
    required this.title,
    required this.director,
    required this.imageUrl,
    required this.description,
    required this.horario,
    this.isFavorite = false,
    this.review = '',
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Movie> movies = [
    Movie(
      title: 'Spider-Man No Way Home',
      director: 'Jon Watts',
      imageUrl: 'assets/images/spiderman1.jpeg',
      description:
          'Es una película estadounidense de superhéroes basada en el personaje Spider-Man, de Marvel Comics...',
      horario: '10:00AM - 1:00PM',
    ),
    Movie(
      title: 'John Wick 4',
      director: 'Chad Stahelski',
      imageUrl: 'assets/images/johnwick.jpeg',
      description:
          'El marqués Vincent de Gramont pretende matar a John Wick para afianzar su poder en la Orden Suprema...',
      horario: '11:00AM - 4:00PM',
    ),
  ];

  @override
Widget build(BuildContext context) {
  final Color primarySwatch = Color.fromARGB(255, 14, 14, 14);
  return MaterialApp(
    title: 'Cartelera',
    theme: ThemeData( 
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Colors.black,
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Cartelera de Películas',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                movies[index].title,
                style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Director: ${movies[index].director}'),
                  Text('Horario: ${movies[index].horario}'),
                ],
              ),
              leading: _buildMovieImage(movies[index].imageUrl),
              trailing: _buildButtons(context, index),
              onTap: () {
                _navigateToMovieDetails(context, movies[index]);
              },
            ),
          );
        },
      ),
    ),
  );
}




  Widget _buildMovieImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        imageUrl,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            movies[index].isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            _toggleFavorite(index);
          },
        ),
        IconButton(
          icon: Icon(Icons.rate_review),
          onPressed: () {
            _openReviewScreen(context, movies[index]);
          },
        ),
      ],
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      movies[index].isFavorite = !movies[index].isFavorite;
    });
  }

  void _openReviewScreen(BuildContext context, Movie movie) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(movie: movie),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        movie.review = result;
      });
    }
  }

  void _navigateToMovieDetails(BuildContext context, Movie movie) {
    String imageUrl;
    if (movie.title == 'Spider-Man No Way Home') {
      imageUrl = 'assets/images/Spiderman.png';
    } else if (movie.title == 'John Wick 4') {
      imageUrl = 'assets/images/johnwick2.jpeg';
    } else {
      imageUrl = 'default_image_url';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(
          movie: movie,
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final String imageUrl;

  MovieDetailScreen({required this.movie, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMovieImage(imageUrl),
              SizedBox(height: 16.0),
              Text(
                'Titulo: ${movie.title}',
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Director: ${movie.director}'
                ,style: TextStyle(
            color: Color.fromARGB(255, 255, 253, 253),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Horario: ${movie.horario}',
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Descripción:',
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              Text(
                movie.description,
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Reseña:',
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
              ),
              Text(
                movie.review.isNotEmpty ? movie.review : 'No hay reseña disponible.',
                style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.asset(
        imageUrl,
        width: double.infinity,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  final Movie movie;

  ReviewScreen({required this.movie});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Reseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pelicula: ${widget.movie.title}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe tu reseña aquí...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: Text('Guardar Reseña'),
            ),
          ],
        ),
      ),
    );
  }
}