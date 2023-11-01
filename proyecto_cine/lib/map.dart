import 'package:flutter/material.dart';
import 'package:proyecto_cine/Sharepreference/Sharepreference.dart';

const MAPBOX_ACCESS_TOKEN =
    'sk.eyJ1IjoiZGFuaWVsanIxMSIsImEiOiJjbG9mNXo4b2UwbHB4MmpxY25hajU1aHg0In0.sy6MlK3pN-GpsfedZb2hBQ';

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
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }