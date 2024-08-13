import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todoapp/Controler/HomeScreenControler/todo_List_controler.dart';
import 'package:todoapp/Resources/Component/RoundButton.dart';
import 'package:todoapp/Resources/Component/inputfeld.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({Key? key, @required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoListControler _todoListControler = Get.put(TodoListControler());

  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDescription = TextEditingController();

  late String email;
  late String userId;
  late String dataId;

  @override
  void initState() {
    // TODO: implement initState
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken["email"];
    userId = jwtDecodedToken["_id"];
    _todoListControler.getTodoList(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const CircleAvatar(
                  child:const Icon(
                    Icons.list,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'ToDo with NodeJS + Mongodb',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                const  SizedBox(height: 8.0),
                Obx(() {
                  return Text(
                    '${_todoListControler.dataItem.value.length} Task',
                    style:const TextStyle(fontSize: 20),
                  );
                }),
                Text(email)
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return Container(
                  decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _todoListControler.dataItem.value == null
                        ? Container()
                        : ListView.builder(
                            itemCount: _todoListControler.dataItem.value.length,
                            itemBuilder: (context, int index) {
                              return Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Color(0xFFFE4A49),
                                        borderRadius: BorderRadius.circular(20),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        onPressed: (BuildContext context) {
                                          _todoListControler.deleteItem(
                                              '${_todoListControler.dataItem.value[index]['_id']}',
                                              userId);
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    borderOnForeground: false,
                                    child: ListTile(
                                      leading: Icon(Icons.task),
                                      title: Row(
                                        children: [
                                          Text(
                                              '${_todoListControler.dataItem.value[index]['title']}'),
                                          IconButton(
                                              onPressed: () {
                                                _displayupdateDialog(
                                                    context,
                                                    _todoListControler.dataItem
                                                        .value[index]['_id']);

                                                //update method
                                              },
                                              icon: Icon(Icons.update)),
                                        ],
                                      ),
                                      subtitle: Text(
                                          '${_todoListControler.dataItem.value[index]['description']}'),
                                      trailing: Icon(Icons.arrow_back),
                                    ),
                                  ));
                            }),
                  ));
            }),
          )
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: const  Icon(Icons.add),
        tooltip: "Add todo data",
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:const Text("Add To-Do Data"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputFeld(controler: todoTitle, hindtext: "Title"),
                const SizedBox(
                  height: 5,
                ),
                InputFeld(controler: todoDescription, hindtext: "Description"),
                const  SizedBox(
                  height: 5,
                ),
                RoundedButton(
                    title: "Add",
                    onPress: () {
                      _todoListControler.addToDoData(
                          context, todoTitle, todoDescription, userId);
                    })
              ],
            ),
          );
        });
  }

  Future<void> _displayupdateDialog(BuildContext context, dataId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update To-Do Data"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputFeld(controler: todoTitle, hindtext: "Title"),
                const SizedBox(
                  height: 5,
                ),
                InputFeld(controler: todoDescription, hindtext: "Description"),
                const   SizedBox(
                  height: 5,
                ),
                RoundedButton(
                    title: "Update",
                    onPress: () {
                      _todoListControler.updateData(
                          context, todoTitle, todoDescription, dataId, userId);
                    })
              ],
            ),
          );
        });
  }
}
