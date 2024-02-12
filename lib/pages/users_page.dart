import 'package:adminpanel/methods/common_methods.dart';
import 'package:flutter/material.dart';

import '../widgets/users_data_list.dart';

class UsersPage extends StatefulWidget {
  static const String id = '\webPageUsers';
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
                'Administrador de Usuarios',
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
              cMethods.header(2, "Usuario ID"),
              cMethods.header(1, "Nombre Usuario"),
              cMethods.header(1, "Email Usuario"),
              cMethods.header(1, "Celular"),
              cMethods.header(1, "Acciones"),
            ],
          ),
          const UsersDataList(),
        ],
      ),
    ));
  }
}
