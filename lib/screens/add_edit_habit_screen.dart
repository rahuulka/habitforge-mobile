import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';

class AddEditHabitScreen extends StatefulWidget {
  final Habit? habit;
  const AddEditHabitScreen({super.key, this.habit});

  @override
  State<AddEditHabitScreen> createState() => _AddEditHabitScreenState();
}

class _AddEditHabitScreenState extends State<AddEditHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;

  @override
  void initState() {
    super.initState();
    name = widget.habit?.name ?? '';
    description = widget.habit?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.habit == null ? 'Add Habit' : 'Edit Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Habit Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                onSaved: (v) => name = v!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                onSaved: (v) => description = v!,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final provider = Provider.of<HabitProvider>(context, listen: false);
                    final habit = Habit(
                      id: widget.habit?.id ?? const Uuid().v4(),
                      name: name,
                      description: description,
                    );
                    if (widget.habit == null) {
                      provider.addHabit(habit);
                    } else {
                      provider.updateHabit(habit);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.habit == null ? 'Create Habit' : 'Update Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}