import 'package:EMIY/controller/BuyShopController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../model/exportmodel.dart';
import '../exportcomponent.dart';

class MapDelevryPage extends StatefulWidget {
  @override
  State<MapDelevryPage> createState() => _MapDelevryPageState();
}

class _MapDelevryPageState extends State<MapDelevryPage> {
  late Marker _position;
  var shopController = Get.find<BuyShopController>();

  var latitude = 0.0;
  var longitude = 0.0;
  initState() {
    // latitude = action.position.latitude;
    // longitude = action.position.longitude;
    latitude = shopController.selected_livraison_point.latitude;
    longitude = shopController.selected_livraison_point.longitude;
    print({latitude, longitude});
    super.initState();
    _position = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        markerId: MarkerId('1'),
        draggable: true,
        infoWindow: InfoWindow(
          title: "Ici",
        ),
        onTap: () {},
        position: LatLng(latitude, longitude));
    print({latitude, longitude});
  }

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    CameraPosition _kLake = CameraPosition(
        bearing: 0, target: LatLng(latitude, longitude), tilt: 50, zoom: 18.5);
    print({'--------------', latitude, longitude});

    return GetBuilder<BuyShopController>(
        builder: (controller) => Scaffold(
            backgroundColor: ColorsApp.bg,
            appBar: AppBar(
                title: Text('positionEtablissement'.tr),
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: ColorsApp.primaryBlue,
                  ),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () {
                    Get.back();
                    // toastShowSuccessLong('positionEta'.tr, Get.context);
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0),
            body: Stack(
              children: [
                Container(
                    height: kHeight * .95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: ColorsApp.white,
                    ),
                    child: GoogleMap(
                        initialCameraPosition: _kLake,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: {_position},
                        // compassEnabled: true,
                        onMapCreated:
                            (GoogleMapController mapcontroller) async {
                          print('-------000------');

                          print('-----1----------------');
                          print({latitude, longitude});
                          // _controller.animateCamera(
                          //     CameraUpdate.newCameraPosition(_kLake));
                          _controller.complete(mapcontroller);
                          mapController = await _controller.future;

                          _controller.future.reactive;

                          print('-------000------');

                          print('-----1----------------');

                          setState(() {
                            _kLake = CameraPosition(
                              bearing: 0,
                              target: LatLng(
                                  controller.selected_livraison_point.latitude,
                                  controller
                                      .selected_livraison_point.longitude),
                              tilt: 50,
                              zoom: 18.5,
                            );

                            _position = Marker(
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueCyan),
                              markerId: MarkerId('1'),
                              draggable: true,
                              infoWindow: InfoWindow(title: "Ici"),
                              onTap: () {},
                              position: LatLng(
                                  controller.selected_livraison_point.latitude,
                                  controller
                                      .selected_livraison_point.longitude),
                            );
                            mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(_kLake));

                            print('Camera animation executed');

                            print('-------------');
                            print('Updated _kLake: $_kLake');
                            print('Updated _position: $_position');
                          });
                        },
                        onTap: (LatLng value) {
                          print(value);
                          controller.selectPoint0(new PointLivraisonModel(
                              id: controller.selected_livraison_point.id,
                              libelle: 'Pres de cette emplacement : ' +
                                  controller.selected_livraison_point.libelle,
                              ville: controller.selected_livraison_point.ville,
                              quartier:
                                  controller.selected_livraison_point.quartier,
                              image: controller.selected_livraison_point.image,
                              longitude: value.longitude,
                              latitude: value.latitude));
                          setState(() {
                            _position = Marker(
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueCyan),
                                markerId: MarkerId('1'),
                                draggable: true,
                                infoWindow: InfoWindow(
                                  title: "Ici",
                                ),
                                onTap: () {},
                                position:
                                    LatLng(value.latitude, value.longitude));
                          });
                        })),
                Positioned(
                  top: 10,
                  child: Container(
                      color: Colors.transparent,
                      // alignment: Alignment.center,
                      height: kHeight * .07,
                      width: kWidth,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.livraison_point.length,
                          itemBuilder: (ctx, i) => GestureDetector(
                                child: Container(
                                    width: kWidth * .4,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controller.livraison_point[i].id ==
                                              controller
                                                  .selected_livraison_point.id
                                          ? ColorsApp.primaryBlue
                                          : ColorsApp.greySecond,
                                    ),
                                    child: Text(
                                      controller.livraison_point[i].libelle,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: controller
                                                    .livraison_point[i].id !=
                                                controller
                                                    .selected_livraison_point.id
                                            ? ColorsApp.primaryBlue
                                            : ColorsApp.greySecond,
                                      ),
                                    )),
                                // onTap: () async {
                                //   print('-------000------');

                                //   controller.selectPoint0(
                                //       controller.livraison_point[i]);
                                //   final GoogleMapController mapController =
                                //       await _controller.future;
                                //   setState(() {
                                //     print('-------dddd------');

                                //     _kLake = CameraPosition(
                                //         bearing: 0,
                                //         target: LatLng(
                                //             controller.selected_livraison_point
                                //                 .latitude,
                                //             controller.selected_livraison_point
                                //                 .longitude),
                                //         tilt: 50,
                                //         zoom: 18.5);
                                //     _position = Marker(
                                //         icon:
                                //             BitmapDescriptor.defaultMarkerWithHue(
                                //                 BitmapDescriptor.hueCyan),
                                //         markerId: MarkerId('1'),
                                //         draggable: true,
                                //         infoWindow: InfoWindow(
                                //           title: "Ici",
                                //         ),
                                //         onTap: () {},
                                //         position: LatLng(
                                //             controller.selected_livraison_point
                                //                 .latitude,
                                //             controller.selected_livraison_point
                                //                 .longitude));
                                //     print('-------------');

                                //     mapController.animateCamera(
                                //         CameraUpdate.newCameraPosition(_kLake));
                                //   });
                                //   setState(() {
                                //     latitude = controller
                                //         .selected_livraison_point.latitude;
                                //     longitude = controller
                                //         .selected_livraison_point.longitude;
                                //   });
                                // }
                                onTap: () async {
                                  controller.selectPoint0(
                                      controller.livraison_point[i]);
                                  _controller.future.reactive;

                                  print('-------000------');

                                  print('-----1----------------');

                                  setState(() {
                                    _kLake = CameraPosition(
                                      bearing: 0,
                                      target: LatLng(
                                          controller.selected_livraison_point
                                              .latitude,
                                          controller.selected_livraison_point
                                              .longitude),
                                      tilt: 50,
                                      zoom: 18.5,
                                    );

                                    _position = Marker(
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueCyan),
                                      markerId: MarkerId('1'),
                                      draggable: true,
                                      infoWindow: InfoWindow(title: "Ici"),
                                      onTap: () {},
                                      position: LatLng(
                                          controller.selected_livraison_point
                                              .latitude,
                                          controller.selected_livraison_point
                                              .longitude),
                                    );
                                    mapController!.animateCamera(
                                        CameraUpdate.newCameraPosition(_kLake));
                                  });
                                },
                              ))),
                )
              ],
            )));
  }
}
