import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remake_ta/location.dart';
import 'package:remake_ta/map_view_type.dart';

class MapOptions{
  final bool showUserLocation;
  final bool showMyLocationButton;
  final bool showCompassButton;
  final bool hideToolbar;

     MapViewType mapViewType;

     MapOptions(
    {this.showUserLocation: false,
    this.showCompassButton: false,
    this.showMyLocationButton: false,
    this.hideToolbar: false
    });

     Map<String, dynamic> toMap(){
       return {
         "showUserLocation": showUserLocation,
         "showMyLocationButton": showMyLocationButton,
         "showCompassButton": showCompassButton,
         "hideToolbar": hideToolbar,
         "mapViewType": getMapTypeName(mapViewType)
       };
     }

 String getMapTypeName(MapViewType mapType) {
       String mapTypeName = "normal";
       switch (mapType){
         case MapViewType.none:
           mapTypeName = "none";
           break;
         case MapViewType.normal:
           mapTypeName = "normal";
           break;
         case MapViewType.satellite:
           mapTypeName = "satellite";
           break;
         case MapViewType.terrain:
           mapTypeName = "terrain";
           break;
         case MapViewType.hybrid:
           mapTypeName = "hybrid";
           break;
       }
       return mapTypeName;
 }
}