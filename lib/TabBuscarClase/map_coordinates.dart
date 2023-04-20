// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treino/states/gps_points.dart';
import 'package:treino/states/gym_coordinates.dart';
import 'page.dart';

// const CameraPosition _kInitialPosition =
//     CameraPosition(target: LatLng(23.332, -102.331), zoom: 11.0);

class MapCoordinatesPage extends GoogleMapExampleAppPage {
  final String lat;
  final String lon;
  MapCoordinatesPage({this.lat, this.lon})
      : super(const Icon(Icons.map), 'Map coordinates');

  @override
  Widget build(BuildContext context) {
    return _MapCoordinatesBody();
    // BlocBuilder<CoordinatesCubit, List<String>>(
    //   builder: (context, val) => _MapCoordinatesBody(
    //     lat: val[0],
    //     lon: val[1],
    //   ),
    // );
  }
}

class _MapCoordinatesBody extends StatefulWidget {
  const _MapCoordinatesBody();
  // final String lat;
  // final String lon;
  @override
  State<StatefulWidget> createState() => _MapCoordinatesBodyState();
}

class _MapCoordinatesBodyState extends State<_MapCoordinatesBody> {
  _MapCoordinatesBodyState();
  CameraPosition initialPos;
  BitmapDescriptor _markerIcon;
  GoogleMapController mapController;
  LatLngBounds _visibleRegion = LatLngBounds(
    southwest: const LatLng(0, 0),
    northeast: const LatLng(0, 0),
  );

  Set<Marker> _createMarker() {
    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
    // https://github.com/flutter/flutter/issues/28312
    // ignore: prefer_collection_literals
    // return <Marker>[
    //   Marker(
    //     onTap: () {
    //       print("la tuya ");
    //     },
    //     markerId: MarkerId("marker_1"),
    //     position: LatLng(double.parse(widget.lat), double.parse(widget.lon)),
    //     icon: _markerIcon,
    //   ),
    // ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    this.initialPos = CameraPosition(
        target: LatLng(context.read<PointsCubit>().puntos[0].latitude,
            context.read<PointsCubit>().puntos[0].longitude),
        zoom: 15.0);

    // print("recibiendo >> " + widget.lat + " // " + widget.lon);
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: this.initialPos,
      // markers: this._createMarker(),
      markers: context.read<PointsCubit>().markers.toSet(),
    );

    final List<Widget> columnChildren = <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        child: googleMap,
      ),
    ];

    if (mapController != null) {
      final String currentVisibleRegion = 'VisibleRegion:'
          '\nnortheast: ${_visibleRegion.northeast},'
          '\nsouthwest: ${_visibleRegion.southwest}';
      // columnChildren.add(Center(child: Text(currentVisibleRegion)));
      // columnChildren.add(_getVisibleRegionButton());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    final LatLngBounds visibleRegion = await controller.getVisibleRegion();
    setState(() {
      mapController = controller;
      _visibleRegion = visibleRegion;
    });
  }

  Widget _getVisibleRegionButton() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RaisedButton(
        child: const Text('Get Visible Region Bounds'),
        onPressed: () async {
          final LatLngBounds visibleRegion =
              await mapController.getVisibleRegion();
          setState(() {
            _visibleRegion = visibleRegion;
          });
        },
      ),
    );
  }
}
