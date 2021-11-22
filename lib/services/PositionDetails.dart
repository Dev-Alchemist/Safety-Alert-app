import 'package:geolocator/geolocator.dart';

class PositionDetails {
  Position _position;
  String _address;

  PositionDetails(this._position, this._address);

  //getters
  Position get position => _position;
  String get address => _address;

  @override
  String toString() {
    return 'PositionDetails: {position: $_position, address: $_address}';
  }

  //setters
  set position(Position newPosition) => this._position = newPosition;
  set address(String newAddress) => this._address = newAddress;
}