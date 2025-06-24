import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  Set<Marker> _markers = {};

  static const LatLng _initialPosition = LatLng(19.4326, -99.1332);

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Los permisos de ubicación fueron denegados')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Los permisos de ubicación están deshabilitados permanentemente',
          ),
        ),
      );
      return;
    }

    _getCurrentLocation();
    _startLocationUpdates();
  }

  Future<void> _getCurrentLocation() async {
    print('hola');
    try {
      print('soy el mapa');
      
      Position position = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ));
      
      print('Ubicación obtenida: $position');

      setState(() {
        _currentPosition = position;

        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(
              title: 'Mi Ubicación',
              snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
            ),
          ),
        );
      });

      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16,
          ),
        ),
      );
    } catch (e) {
      print('Error obteniendo ubicación: $e'); // Para depuración
    }
  }

  void _startLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
      Position position,
    ) {
      setState(() {
        _currentPosition = position;

        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(
              title: 'Mi Ubicación',
              snippet: 'Actualizada en tiempo real',
            ),
          ),
        );
      });

      _controller?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Ubicación en Tiempo Real'),
        backgroundColor: Colors.blue[800],
        actions: [
          ElevatedButton(
            onPressed: _getCurrentLocation,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              elevation: 0,
            ),
            child: Icon(Icons.my_location),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),

          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Coordenadas Actuales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.location_on, color: Colors.red),
                          Text('Latitud'),
                          Text(
                            _currentPosition?.latitude.toStringAsFixed(6) ??
                                'No disponible',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue),
                          Text('Longitud'),
                          Text(
                            _currentPosition?.longitude.toStringAsFixed(6) ??
                                'No disponible',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
