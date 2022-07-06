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
enum SocialNetwork { facebook, instagram, twitter }
enum OptionTab {home,operations,myOffers,profile}
enum Language { spanish, english }
enum TypeMoney { dlycop, cop }

enum NavigateOption {
  history,
  support,
  settings,
  logout,
}

enum DailyConnectType { walletAddress, transaction }

enum OfferStatus {
  Publicado,
  Pendiente,
  Cerrado,
  pending,
  Pagado,
  Disputa,
}

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
