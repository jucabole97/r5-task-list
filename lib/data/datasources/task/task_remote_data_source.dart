import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r5_task_list/core/shared_preferences_manager.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class for the Authentication remote data source.
abstract class TaskRemoteDataSource {

  Future<List<Task>> getTaskList();

  Future<bool> createTask({ required Task task });

  Future<bool> updateTask({ required Task task });

  Future<bool> deleteTask({ required String docId });
  
}

/// Implementation of the Authentication remote data source
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {

  final CollectionReference _tasksCollection =
    FirebaseFirestore.instance.collection('tasks');
  final SharedPreferences _sharedPreferencesManager;

  TaskRemoteDataSourceImpl({
    SharedPreferences? sharedPreferencesManager
  }) : _sharedPreferencesManager = sharedPreferencesManager ?? sharedPreferences;
  
  @override
  Future<List<Task>> getTaskList() async {
    try {
      final QuerySnapshot snapshot = await _tasksCollection
          .where('user_id', isEqualTo: _getCurrentUserUid)
          .get();

      final List<Task> tasks = snapshot.docs.map((doc) {
        final data = doc.data();
        return Task.fromJson(data, doc.id);
      }).toList();

      return tasks;
    } catch (e) {
      return <Task>[];
    }
  }

  @override
  Future<bool> createTask({ required Task task }) async {
    final Task taskToSend = task.copyWith(userId: _getCurrentUserUid);
    try {
      await _tasksCollection.add(taskToSend.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateTask({ required Task task }) async {
    final Task taskToSend = task.copyWith(userId: _getCurrentUserUid);
    try {
      await _tasksCollection.doc(taskToSend.id).update(taskToSend.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTask({ required String docId }) async {
    try {
      await _tasksCollection.doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  String? get _getCurrentUserUid => _sharedPreferencesManager.getString('uid');
}