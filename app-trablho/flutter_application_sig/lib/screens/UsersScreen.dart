import 'package:flutter/material.dart';
import 'package:flutter_application_sig/domain/models.dart';
import 'package:flutter_application_sig/screens/InfoModal.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controllers/usersController.dart';
import '../repositories/global_repository.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final controller = UsersController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controller.makeGetRequest();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _renderListView(List<User> users, ScrollController controller) {
    return ListView.builder(
      controller: controller,
      itemCount: users.length,
      itemBuilder: (context, index) {
        var data = users[index];
        return Container(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child:
                  Icon(Icons.supervised_user_circle_sharp, color: Colors.white),
            ),
            title: Text(
              data.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          title: const Text(
            "Usuarios",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.sync,
                color: Colors.white,
              ),
              onPressed: () {
                controller.makeGetRequest();
              },
            ),
          ],
          backgroundColor: SECONDARY_COLOR),
      body: LayoutBuilder(builder: (context, constraints) {
        return ValueListenableBuilder<List<User>>(
          valueListenable: controller.resultNotifier,
          builder: (context, users, child) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                gradient: PRIMARY_GRADIENT,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 18.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        users.isEmpty
                            ? const Text(
                                "Carregando...",
                                style: TextStyle(color: Colors.white),
                              )
                            : Expanded(
                                child:
                                    _renderListView(users, _scrollController)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
