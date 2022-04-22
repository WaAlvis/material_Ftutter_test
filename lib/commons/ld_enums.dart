enum RegisterStep {
  emailStep_1,
  msjEmailStep_2,
  validatePinStep_3,
  accountDataStep_4,
  personalDataStep_5,
  // dataWalletStep_6
}

enum TypeOffer { sell, buy }

enum NavigateOption {
  history,
  support,
  settings,
  logout,
}

enum DailyConnectType { walletAddress, transaction }

enum OfferStatus {
  open,
  inProcess,
  closed,
  pending,
}

enum NotificationType {
  c, // Compra
  v, // Venta
  sv, // Soporte Compra
  sc, // Soporte Venta
  t, // Tiempo
}
