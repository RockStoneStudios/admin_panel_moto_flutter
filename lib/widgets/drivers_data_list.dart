import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:adminpanel/methods/common_methods.dart';
import 'package:image_network/image_network.dart';

class DriversDataList extends StatefulWidget {
  const DriversDataList({Key? key}) : super(key: key);

  @override
  State<DriversDataList> createState() => _DriversDataListState();
}

class _DriversDataListState extends State<DriversDataList> {
  final driversRecordsFromDatabase =
      FirebaseDatabase.instance.ref().child("drivers");
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: driversRecordsFromDatabase.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshotData) {
        if (snapshotData.hasError) {
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshotData.data?.snapshot.value == null) {
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

        Map<String, dynamic> dataMap =
            Map<String, dynamic>.from(snapshotData.data!.snapshot.value as Map);
        List<Map<String, dynamic>> itemsList = dataMap.entries.map((entry) {
          var value = Map<String, dynamic>.from(entry.value);
          value["id"] = entry.key; // Ensure the ID is included
          return value;
        }).toList();

        return ListView.builder(
          shrinkWrap: true,
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            var item = itemsList[index];
            var carDetails = item["car_details"] ?? {};
            var photoUrl = item["photo"]?.toString() ?? '';
            debugPrint("Intentando cargar la imagen de la URL: $photoUrl");

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cMethods.data(
                  2,
                  Text(item["id"].toString()),
                ),
                cMethods.data(
                    1,
                    ImageNetwork(
                      image: item["photo"].toString(),
                      width: 60,
                      height: 60,
                      onError: const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    )),
                cMethods.data(
                  1,
                  Text(item["name"].toString()),
                ),
                cMethods.data(
                  1,
                  Text(
                      "${carDetails["carModel"] ?? 'N/A'} - ${carDetails["carNumber"] ?? 'N/A'}"),
                ),
                cMethods.data(
                  1,
                  Text(item["phone"].toString()),
                ),
                cMethods.data(
                  1,
                  Text("\$ ${item["earnings"]?.toString() ?? '0'}"),
                ),
                cMethods.data(
                  1,
                  item["blockStatus"] == "no"
                      ? ElevatedButton(
                          onPressed: () async {
                            await driversRecordsFromDatabase
                                .child(item["id"])
                                .update({
                              "blockStatus": "yes",
                            });
                          },
                          child: const Text(
                            "Block",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await driversRecordsFromDatabase
                                .child(item["id"])
                                .update({
                              "blockStatus": "no",
                            });
                          },
                          child: const Text(
                            "Approve",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
