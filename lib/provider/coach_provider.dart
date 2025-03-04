import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The currently logged-in coach ID
final StateProvider<int?> coachProvider = StateProvider<int?>((Ref ref) => null);