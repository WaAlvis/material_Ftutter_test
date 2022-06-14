import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLoginUtils {
  static Future<bool> canHandleBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    return auth.isDeviceSupported();
  }

  static Future<bool> handleBiometricAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool didAuthenticate = false;
    if (await canHandleBiometrics()) {
      try {
        didAuthenticate = await auth.authenticate(
          localizedReason: 'Inicio de sesión biométrico',
          options: const AuthenticationOptions(biometricOnly: true),
        );
      } catch (e) {
        if (e is PlatformException) {
          if (e.message == 'No biometrics enrolled on this device.')
            print('Biométrico sin configurar');
        }
      }
    }

    return didAuthenticate;
  }
}
