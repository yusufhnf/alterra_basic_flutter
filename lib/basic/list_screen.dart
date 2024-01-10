import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final todoCubit = TodoCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => todoCubit,
        child: BlocBuilder<TodoCubit, TodoState>(
          bloc: todoCubit,
          builder: (context, state) {
            return state.when(
                initial: () => const SizedBox.shrink(),
                empty: () => const Center(
                      child: Text(
                        'No todos yet',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                loaded: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              todoCubit.deleteTodoByIndex(index: index);
                            },
                          ),
                        );
                      },
                    ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = '';

        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            onChanged: (value) {
              newTodo = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                todoCubit.addTodo(
                  todoText: newTodo,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    todoCubit.close();
    super.dispose();
  }
}
