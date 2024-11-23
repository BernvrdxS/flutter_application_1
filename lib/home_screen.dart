import 'package:flutter/material.dart';
import 'add_goal_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _goals = [];

  void _addGoal(String title, String description, String status) {
    setState(() {
      _goals.add({
        'title': title,
        'description': description,
        'status': status,
      });
    });
  }

  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkpoints'),
        backgroundColor: Colors.purple,
      ),
      body: _goals.isEmpty
          ? Center(
              child: Text(
                'Nenhuma meta adicionada!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(goal['title'] ?? 'Sem título'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(goal['description'] ?? 'Sem descrição'),
                        Text(
                          'Status: ${goal['status'] ?? 'Indefinido'}',
                          style: TextStyle(
                            color: goal['status'] == 'Concluída'
                                ? Colors.green
                                : goal['status'] == 'Em Atraso'
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteGoal(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGoalScreen(),
            ),
          );
          if (result != null && result is Map<String, String>) {
            _addGoal(result['title']!, result['description']!, result['status']!);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
