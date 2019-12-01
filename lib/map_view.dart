import 'dart:async';
import 'package:flutter/services.dart';
import 'location.dart';
import 'map_options.dart';
import 'toolbar_action.dart';
import 'polygon.dart';

export 'location.dart';
export 'locations.dart';
export 'toolbar_action.dart';
export 'map_options.dart';


class MapView {
  MethodChannel _channel = const MethodChannel("com.apptreesoftware.map_view");

  StreamController<Polygon2> _polygonStreamController =
  new StreamController.broadcast();
  StreamController<Null> _mapReadyStreamController =
  new StreamController.broadcast();
  StreamController<Location> _locationChangeStreamController =
  new StreamController.broadcast();

  Map<String, Polygon2> _polygons = {};

  MapView(){
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<Location> get centerLocation async{
    Map locationMap = await _channel.invokeMethod("getCenter");
    return new Location(locationMap["latitde"], locationMap["longtitude"]);
  }

  static bool _apiKeySet = false;

  static void setApiKey(String apiKey) {
    MethodChannel c = const MethodChannel("com.apptreesoftware.map_view");
    c.invokeMethod('setApiKey', apiKey);
    _apiKeySet = true;
  }

  void show(MapOptions mapOptions, {List<ToolbarAction> toolbarActions}) {
    if (!_apiKeySet) {
      throw "API Key must be set before calling `show`. Use MapView.setApiKey";
    }
    List<Map> actions = [];
    if (toolbarActions != null) {
      actions = toolbarActions.map((t) => t.toMap).toList();
    }
    print(mapOptions.toMap());
    _channel.invokeMethod(
        'show', {"mapOptions": mapOptions.toMap(), "actions": actions});
  }

  void dismis(){
    _polygons.clear();
    _channel.invokeMethod('dismiss');
  }

  List<Polygon2> get polygons => _polygons.values.toList(growable: false);

  void setPolygons(List<Polygon2> polygons){
    _polygons.clear();
    polygons.forEach((a) => _polygons[a.id] = a);
    _channel.invokeMethod('setPolygons', polygons.map((a)=> a.toMap()).toList(growable: false));
  }

  void clearPolygons(){
    _channel.invokeMethod('clearPolygons');
    _polygons.clear();
  }

  void addPolygon(Polygon2 polygon){
    if (_polygons.containsKey(polygon.id)) {
      return;
    }
    _polygons[polygon.id] = polygon;
    _channel.invokeMethod('addPolygon', polygon.toMap());
  }

  void removePolygon(Polygon2 polygon) {
    if (!_polygons.containsKey(polygon.id)) {
      return;
    }
    _polygons.remove(polygon.id);
    _channel.invokeMethod('removePolygon', polygon.toMap());
  }

  Future<List<Polygon2>> get visiblePolygons async {
    List<dynamic> ids = await _channel.invokeMethod("getVisiblePolygons");
    for (var id in ids) {
      var polygon = _polygons[id];
      polygons.add((polygon));
    }
    return polygons;
  }

  Stream<Polygon2> get onTouchPolygon => _polygonStreamController.stream;
  Stream<Location> get onLocationUpdated => _locationChangeStreamController.stream;
  Stream<Null> get onMapReady => _mapReadyStreamController.stream;

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {

      case "onMapReady":
        _mapReadyStreamController.add(null);
        return new Future.value("");
      case "locationUpdated":
        Map args = call.arguments;
        _locationChangeStreamController.add(new Location.fromMapFull(args));
        return new Future.value("");
      case "polygonTapped":
        String id = call.arguments;
        var polygon = _polygons[id];
        if (polygon != null) {
          _polygonStreamController.add(polygon);
        }
        return new Future.value("");

    }
    return new Future.value("");
  }
}