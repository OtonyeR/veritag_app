import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:veritag_app/services/location.dart';

class ManufactureScreen extends StatefulWidget {
  const ManufactureScreen({super.key});

  @override
  State<ManufactureScreen> createState() => _ManufactureScreenState();
}

class _ManufactureScreenState extends State<ManufactureScreen> {
  String currentAddress = '';
  Position? currentPosition;
  final LocationService locationService = LocationService();
  String uuid = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void generateNewUuid() {
    setState(() {
      uuid = const Uuid().v4(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(currentAddress),
            const SizedBox(height: 10),
            Text(uuid),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getCurrentLocation();
            generateNewUuid();
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      String address = await locationService.getAddressFromLatLng(position);
      setState(() {
        currentAddress = address;
      });
    } catch (e) {
      print(e);
      setState(() {
        currentAddress = 'Failed to get address';
      });
    }
  }
}
