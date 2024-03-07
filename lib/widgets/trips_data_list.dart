import 'package:adminpanel/methods/common_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripsDataList extends StatefulWidget {
  const TripsDataList({super.key});

  @override
  State<TripsDataList> createState() => _TripsDataListState();
}

class _TripsDataListState extends State<TripsDataList> {
  final completedTripsRecordsFromDatabase = FirebaseDatabase.instance.ref().child("tripRequests");
  CommonMethods cMethods = CommonMethods();

  launchGoogleMapFromSourceToDestination(pickUpLat, pickUpLng, dropOffLat, dropOffLng) async {
    String directionAPIUrl = "https://www.google.com/maps/dir/?api=1&origin=$pickUpLat,$pickUpLng&destination=$dropOffLat,$dropOffLng&dir_action=navigate";
    if (await canLaunchUrl(Uri.parse(directionAPIUrl))) {
      await launchUrl(Uri.parse(directionAPIUrl));
    } else {
      print("Historial: Could not launch google map");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: completedTripsRecordsFromDatabase.onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshotData) {
        print("Historial: Connection state: ${snapshotData.connectionState}");
        if (snapshotData.hasError) {
          print("Historial: Error: ${snapshotData.error}");
          return const Center(
            child: Text(
              "Error Occurred. Try Later.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.pink,
              ),
            ),
          );
        }

        if (snapshotData.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshotData.data?.snapshot.value == null) {
          print("Historial: Snapshot data is null");
          return const Center(
            child: Text(
              "No data available.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          );
        }

        Map dataMap = snapshotData.data!.snapshot.value as Map;
        List itemsList = [];
        dataMap.forEach((key, value) {
          print("Historial: Adding item to list: $key => $value");
          itemsList.add({"key": key, ...value});
        });

        print("Historial: Total items in the list: ${itemsList.length}");

        return ListView.builder(
          shrinkWrap: true,
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            if (itemsList[index]["status"] != null && itemsList[index]["status"] == "ended") {
              print("Historial: Item with 'ended' status found: ${itemsList[index]}");
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cMethods.data(2, Text(itemsList[index]["tripID"].toString())),
                  cMethods.data(1, Text(itemsList[index]["userName"].toString())),
                  cMethods.data(1, Text(itemsList[index].containsKey("driverName") ? itemsList[index]["driverName"].toString() : "N/A")),
                  cMethods.data(1, Text(itemsList[index].containsKey("carDetails") ? itemsList[index]["carDetails"].toString() : "N/A")),
                  cMethods.data(1, Text(itemsList[index]["publishDateTime"].toString())),
                  cMethods.data(1, Text("\$ " + (itemsList[index]["fareAmount"] ?? "N/A").toString())),
                  cMethods.data(
                    1,
                    ElevatedButton(
                      onPressed: () {
                        String pickUpLat = itemsList[index]["pickUpLatLng"]["latitude"].toString();
                        String pickUpLng = itemsList[index]["pickUpLatLng"]["longitude"].toString();
                        String dropOffLat = itemsList[index]["dropOffLatLng"]["latitude"].toString();
                        String dropOffLng = itemsList[index]["dropOffLatLng"]["longitude"].toString();

                        launchGoogleMapFromSourceToDestination(pickUpLat, pickUpLng, dropOffLat, dropOffLng);
                      },
                      child: const Text(
                        "View More",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              print("Historial: Item does not have 'ended' status or is missing: ${itemsList[index]}");
              return Container();
            }
          },
        );
      },
    );
  }
}
