import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить задачу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Заголовок'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите заголовок задачи';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание задачи';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Ссылка на изображение'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: Uuid().v4(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: DateTime.now(),
                      imageUrl: _imageUrlController.text,
                    );
                    Provider.of<TaskProvider>(context, listen: false)
                        .addTask(newTask);
                    Navigator.pop(context);
                  }
                },
                child: Text('Добавить задачу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
