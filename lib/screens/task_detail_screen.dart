import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/image_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${task.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${task.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${task.date.toString()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            task.imageUrl.isNotEmpty
                ? Column(
              children: [
                Image.network(task.imageUrl,
                  width: 200, // Фиксированная ширина изображения в описании
                  height: 200, // Фиксированная высота изображения в описании
                  fit: BoxFit.cover,),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ImageScreen(imageUrl: task.imageUrl),
                      ),
                    );
                  },
                  child: Text('Показать изображение'),
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
