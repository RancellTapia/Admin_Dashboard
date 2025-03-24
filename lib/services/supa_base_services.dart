import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 🔹 Obtener usuario actual
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// 🔹 Verificar si hay una sesión activa
  bool isLoggedIn() {
    return _supabase.auth.currentSession != null;
  }

  /// 🔹 Registro de usuario
  Future<AuthResponse> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      final user = response.user;

      if (user == null) {
        throw Exception('No se pudo crear el usuario');
      }

      print(user.id);
      return response;
    } on AuthException catch (e) {
      throw Exception('Error al registrarse: ${e.message}');
    }
  }

  /// 🔹 Iniciar sesión
  Future<AuthResponse> logIn(String email, String password) async {
    try {
      final response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      return response;
    } on AuthException catch (e) {
      throw Exception('Error al iniciar sesión: ${e.message}');
    }
  }

  /// 🔹 Cerrar sesión
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// 🔹 Leer datos de la tabla "appointments"
  Future<List<dynamic>> getAppointments() async {
    final user = getCurrentUser();
    if (user == null) throw Exception("Usuario no autenticado");

    final response =
        await _supabase.from('appointments').select().eq('user_id', user.id);
    return response;
  }

  /// 🔹 Agregar una cita a la tabla "appointments"
  Future<void> addAppointment(String doctorId, DateTime dateTime) async {
    final user = getCurrentUser();
    if (user == null) throw Exception("Usuario no autenticado");

    final response = await _supabase.from('appointments').insert({
      'user_id': user.id,
      'doctor_id': doctorId,
      'date_time': dateTime.toIso8601String(),
    });

    if (response.error != null) {
      throw Exception("Error al agendar cita: ${response.error!.message}");
    }
  }

  /// 🔹 Eliminar una cita por ID
  Future<void> deleteAppointment(String appointmentId) async {
    final response =
        await _supabase.from('appointments').delete().eq('id', appointmentId);
    if (response.error != null) {
      throw Exception("Error al eliminar cita: ${response.error!.message}");
    }
  }
}
