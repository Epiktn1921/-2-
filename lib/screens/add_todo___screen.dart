import 'package:flutter/material.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  final Todo? todo; 

  const AddTodoScreen({super.key, this.todo});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _textController = TextEditingController(text: widget.todo?.text ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final newTodo = Todo(
        id: widget.todo?.id, 
        title: _titleController.text.trim(),
        text: _textController.text.trim(),
        isCompleted: widget.todo?.isCompleted ?? false,
        createdAt: widget.todo?.createdAt,
      );
      Navigator.pop(context, newTodo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.todo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактировать задачу' : 'Новая задача'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTodo,
            tooltip: 'Сохранить',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Заголовок *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите заголовок';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
