import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../injector.dart';
import 'auth.dart';
import 'complete_profile.dart';

class EnteryPoint extends StatelessWidget {
  const EnteryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return sl<SupabaseClient>().auth.currentUser == null
        ? const AuthView()
        : const CompleteProfileView();
  }
}
