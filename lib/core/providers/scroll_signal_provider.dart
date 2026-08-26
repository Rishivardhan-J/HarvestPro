import 'package:flutter_riverpod/flutter_riverpod.dart';

// Keyed by tab index. Emits a timestamp when a double-tap occurs so UI can scroll to top.
final scrollToTopSignalProvider = StateProvider.family<DateTime?, int>((ref, tabIndex) => null);
