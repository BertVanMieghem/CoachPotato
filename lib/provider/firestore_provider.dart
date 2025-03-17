import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<FirebaseFirestore> firestoreProvider = Provider<FirebaseFirestore>((Ref ref) => FirebaseFirestore.instance);
