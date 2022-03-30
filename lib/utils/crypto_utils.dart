class CryptoUtils {
  static String trimHash(String hash) {
    try {
      return '${hash.substring(0, 10)}...${hash.substring(hash.length - 8, hash.length)}';
    } catch (error) {
      return 'Error...';
    }
  }
}
