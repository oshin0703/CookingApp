import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/recipe_card_item.dart';

class MealHistoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference get _userMeals =>
      _firestore.collection('users').doc(_uid).collection('meals');

  Future<List<RecipeInfo>> fetchHistory() async {
    if (_uid == null) return [];

    try {
      final snapshot = await _userMeals.orderBy('date', descending: true).get();
      return snapshot.docs.map((doc) {
        return RecipeInfo.fromMap(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
      }).toList();
    } catch (e) {
      print('Error fetching history: $e');
      return [];
    }
  }

  Future<void> addMeal(RecipeInfo recipe) async {
    if (_uid == null) {
      print('Error: User is not authenticated');
      return;
    }

    try {
      print('Adding meal for user: $_uid');
      await _userMeals.add(recipe.toMap()).timeout(const Duration(seconds: 10));
      print('Meal added successfully');
    } catch (e) {
      print('Error adding meal: $e');
      rethrow;
    }
  }
}
