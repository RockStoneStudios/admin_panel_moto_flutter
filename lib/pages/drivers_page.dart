import 'package:adminpanel/methods/common_methods.dart';
import 'package:adminpanel/widgets/drivers_data_list.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  static const String id = '\webPageDrivers';
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriversPage> {
  CommonMethods cMethods = CommonMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Administrador de Conductores',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              cMethods.header(2, "Driver ID"),
              cMethods.header(1, "Picture"),
              cMethods.header(1, "Name"),
              cMethods.header(1, "Car Details"),
              cMethods.header(1, "Phone"),
              cMethods.header(1, "Total Earnings"),
              cMethods.header(1, "Actions")
            ],
          ),
          DriversDataList()
        ],
      ),
    ));
  }
}
