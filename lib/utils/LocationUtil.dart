import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:students_safety_app/services/PositionDetails.dart';
import 'package:students_safety_app/shared/SnackBarWidget.dart';

class LocationUtil {
  static Future<PositionDetails?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SnackBarWidget.customSnackBar(
          content: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        Fluttertoast.showToast(msg: 'Location permissions are denied',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.redAccent);

      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permissions are permanently denied, App cannot request permissions.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent);
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placeMarks[0];

      Position currentPosition = position;
      String currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";

      PositionDetails positionDetails =
          PositionDetails(currentPosition, currentAddress);
      return positionDetails;
    } catch (e) {
      print(e);

      if (position.latitude != null) {
        // if only geocoding has failed
        Fluttertoast.showToast(msg: 'Oops! Apps could not fetch Address.',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.redAccent);

        PositionDetails positionDetails = PositionDetails(position, "");
        return positionDetails;
      } else {
        Fluttertoast.showToast(msg: 'Sorry! Geolocation could not be fetched. SOS Failed.',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.redAccent);
        //if both geolocator and geocoding failed
        return null;
      }
    }
  }
}
