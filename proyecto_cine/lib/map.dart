import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:proyecto_cine/Login.dart';
import 'package:proyecto_cine/Sharepreference/Sharepreference.dart';


// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiZGFuaWVsanIxMSIsImEiOiJjbG5lcXhiYTgwZThhMmpvNGtlNG1vcTdxIn0.xLcplNW4L11ON3Ekf3wpaQ';

class MapScreen extends StatefulWidget {
  static const String nombre = 'mapa';
   
   MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final prefs = PrefernciaUsuario();
  
  PageController _pageController = PageController();
  bool showStoreDetails = false;
  String selectedStoreName = "";
  //animations marker
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  LatLng? myPosition;
  String? selectedCategory; // Categoría seleccionad a

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void showDetails(String storeName) {
    setState(() {
      selectedStoreName = storeName;
      showStoreDetails = true;
    });
  }

  void hideDetails() {
    setState(() {
      showStoreDetails = false;
    });
  }

  void getCurrentLocation() async {
    Positioned position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  @override
  void initState() {
    //initialization

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    sizeAnimation = Tween<double>(
      begin: 30.0,
      end: 60.0,
    ).animate(animationController);
    animationController.repeat(reverse: true);

    print(animationController);
//animationController.forward();
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
     prefs.ultimapagina = LoginPage.nombre;
    return Scaffold(
    appBar: AppBar(
      title: Text("Bienvenido ${prefs.usuario}", textAlign:TextAlign.center , style: TextStyle(color: Colors.white)),
      backgroundColor:Colors.black,
       centerTitle: true,
    ),
    drawer: Drawer(child: ListView(children:<Widget>[
      
     DropdownButtonFormField<String>(
                      value: selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      items: ['All Categories', ...getUniqueCategories(Cine)]
                          .map((categoria) {
                        return DropdownMenuItem(
                          value: categoria,
                          child: Text(categoria),
                          
                          
                        );
                      }).toList(),
                          decoration: InputDecoration(
                            labelText: "Seek",
                            filled: true,
                            fillColor: Colors.black,

                          //filled: true,
                          //fillColor: Colors.,
                          ),  
                      style: const TextStyle(
                        color:  Colors.white,
                        fontSize: 16.0,
                      ),
                    )
    ])),
      //  drawer: DrawerButtonIcon(),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          center: myPosition!,
                          minZoom: 5,
                          maxZoom: 35,
                          zoom: 15,
                        ),
                        nonRotatedChildren: [
                          TileLayer(
                            urlTemplate:
                                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                            additionalOptions: const {
                              'accessToken': MAPBOX_ACCESS_TOKEN,
                              'id': 'mapbox/dark-v10'
                            },
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                height: 80,
                                width: 80,
                                point: myPosition!,
                                builder: (BuildContext context) {
                                  return AnimatedBuilder(
                                    animation: sizeAnimation,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      // print("animationController.value: ${animationController.value}");
                                      return Center(
                                        child: Image.asset(
                                          "assets/images/marker2.png",
                                          width: sizeAnimation.value,
                                          height: sizeAnimation.value,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              // Filtrar y agregar marcadores para las tiendas
                              ...getFilteredStores(Cine, selectedCategory)
                                  .map((tienda) {
                                return Marker(
                                  height: 50,
                                  width: 50,
                                  point:
                                      LatLng(tienda.latitud, tienda.longitud),
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        //    _pageController.animateToPage(tiendas.indexOf(tienda),duration: const Duration(milliseconds: 500), curve:Curves.bounceIn);
                                        print(tienda);
                                        setState(() {
                                          showStoreDetails = true;
                                          selectedStoreName = tienda.nombre;
                                        });
                                      },
                                      child: AnimatedBuilder(
                                        animation: sizeAnimation,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          //    print("animationController.value: ${animationController.value}");
                                          return Center(
                                            child: Image.asset(
                                              "assets/images/tienda.png",
                                              width: sizeAnimation.value,
                                              height: sizeAnimation.value,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                      if (showStoreDetails)
                        Positioned(
                          bottom: 20, // Muestra la tarjeta en la parte inferior
                          left: 0,
                          right: 0,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return _MapItemDetails(
                                  selectedStoreName: selectedStoreName);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  
  TileLayer({required String urlTemplate, required Map<String, String> additionalOptions}) {}
  
  FlutterMap({required options, required List nonRotatedChildren}) {}
  
  MapOptions({required center, required int minZoom, required int maxZoom, required int zoom}) {}
  
  MarkerLayer({required List<dynamic> markers}) {}
  
  getFilteredStores(List<Cines> cine, String? selectedCategory) {}
  
  LatLng(latitud, longitud) {}

  
}

class Cines {
  final String nombre;
  final double latitud;
  final double longitud;
  final List<String> resenas;
  final String horarios;
  final String imagen;

  Cines({
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.resenas,
    required this.horarios,
    required this.imagen,
  });
}

final List<Cines> Cine = [
  Cines(
    nombre: 'Cine Colombia',
    latitud: 10.907399090308166,
    longitud: -74.80040072594659,
    resenas: ['Buen hambiente y excelente calidad', 'Gran servicio'],
    horarios: 'Lun-Vie: 10 AM - 10 PM',
    imagen: "assets/images/CC.png",
  ),
  Cines(
    nombre: 'Royal Films',
    latitud: 10.990993161905982,
    longitud: -74.78812693782318,
    resenas: ['Buenos pasabocas', 'Excelente servicio'],
    horarios: 'Lun-Vie: 10 AM - 10 PM',
    imagen: "assets/images/royal-films.png",
  ),
  Cines(
    nombre: 'CineLand',
    latitud: 10.989580120190793,
    longitud: -74.7895565241333,
    resenas: ['Buen hambiente y excelente sonido', 'Excelente servicio'],
    horarios: 'Lun-Vie: 8 AM - 7 PM',
    imagen: "assets/images/Optica.jpeg",
  ),
];

class _MapItemDetails extends StatelessWidget {
  final String selectedStoreName;

  _MapItemDetails({required this.selectedStoreName});
  @override
  Widget build(BuildContext context) {
    // Busca la tienda correspondiente en la lista
    final store =
        Cine.firstWhere((store) => store.nombre == selectedStoreName,
            orElse: () => Cines(
                  nombre: '',
                  latitud: 0.0,
                  longitud: 0.0,
                  resenas: [],
                  horarios: '',
                  imagen: "",
                ));

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      margin: EdgeInsets.only(top: 20.0),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20.0), // Margen izquierdo
                      child: Image.asset(
                        store.imagen,
                      )),
                ),
                Expanded(
                  child: Container(
                    //padding:EdgeInsets.only(left: 00.0), // Ajusta el margen izquierdo
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Alinea el texto a la izquierda
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            store.nombre,
                            style: TextStyle(
                                fontSize: 15.0, // Tamaño de fuente
                                fontWeight:
                                    FontWeight.bold, // Peso de la fuente
                                color: Colors.black // Color del texto
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text(
                            'Reseñas: ${store.resenas.join(", ")}',
                            style: TextStyle(
                              fontSize: 11.0, // Tamaño de fuente
                              fontWeight: FontWeight.bold, // Peso de la fuente
                              color: Colors.grey, // Color del texto
                            ),
                          ),
                        ),
                        
                        Text(
                          'Horarios: ${store.horarios}',
                          style: TextStyle(
                            fontSize: 11.0, //Tamaño de fuente
                            fontWeight: FontWeight.bold, // Peso de la fuente
                            color: Colors.grey, // Color del texto
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        Column(
  children: [
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Alinea los botones al centro
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0), // Aplicar margen a la derecha
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Color de fondo del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0), // Ajusta el espacio horizontal
              ),
              icon: Icon(
                Icons.directions,
                color: Colors.white, 
              ),
              label: Text(
                'Como llegar', // Texto del botón
                style: TextStyle(
                  color: Colors.white, // Color del texto
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: MaterialButton(
              onPressed: () {
                // Función a ejecutar cuando se presione el botón de notificación
              },
              color: Colors.black, // Color de fondo del botón
              shape: CircleBorder(), // Forma del botón (circular)
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Espacio entre el ícono y el borde del botón
                child: Icon(
                  Icons.notifications, // Icono de navegación
                  size: 24, // Tamaño del icono
                  color: Colors.white, // Color del icono
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),


          ],
        ),
      ),
    );
  }
}
