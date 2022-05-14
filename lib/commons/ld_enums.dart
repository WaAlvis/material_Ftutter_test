// ignore_for_file: constant_identifier_names

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

enum OfferStatus { Publicado, Pendiente, Cerrado, pending, Pagado }

enum NotificationType {
  c, // Compra
  v, // Venta
  sv, // Soporte Compra
  sc, // Soporte Venta
  t, // Tiempo
}

enum SupportType {
  LocalDLYGeneral,
  LocalDLYBuy,
  LocalDLYSale,
}

enum SupportStatus {
  Abierto,
  Proceso,
  Cerrado,
}
