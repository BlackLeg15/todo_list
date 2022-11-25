import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String newTodoContent = '';

  final todoList = <TodoModel>[];

  void add(String description) {
    final todoModel = TodoModel(id: UniqueKey().toString(), description: description);
    setState(() {
      todoList.add(todoModel);
    });
  }

  void remove(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todoModel = todoList[index];
          return ListTile(
            title: Text(todoModel.description),
            leading: Text(todoModel.id.toString()),
            trailing: IconButton(
              onPressed: () {
                remove(index);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              label: Text('Digite o conteúdo'),
                            ),
                            onChanged: (value) {
                              newTodoContent = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              add(newTodoContent);
                              newTodoContent = '';
                              Navigator.pop(context);
                            },
                            child: const Text('Adicionar'),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
