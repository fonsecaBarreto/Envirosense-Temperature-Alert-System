import 'package:flutter/material.dart';

import '../constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        const DrawerHeader(
            decoration: const BoxDecoration(color: PRIMARY_COLOR),
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            )),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () => {Navigator.pushNamed(context, '/')},
        ),
        ListTile(
          leading: const Icon(Icons.supervised_user_circle_sharp),
          title: const Text('Usuarios'),
          onTap: () => {Navigator.pushNamed(context, '/users')},
        ),
      ]),
    );
  }
}
