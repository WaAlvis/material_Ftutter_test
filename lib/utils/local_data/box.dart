import 'dart:convert';

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class BoxDataSesion {
  static late Box<Person> box;
  static late Box<CurrentUser> boxCurrentUser;
  static late Box<RememberMe> boxRememberMe;
  static late Box<dynamic> boxActivity;
  static late Box<dynamic> boxAudioGuides;
  static final ready = BehaviorSubject.seeded(false);

  static final BoxDataSesion _boxData = BoxDataSesion._internal();

  factory BoxDataSesion() {
    return _boxData;
  }

  BoxDataSesion._internal() {
    Rx.combineLatestList([
      boxSession().then((value) => box = value).asStream(),
      boxSessionCurr().then((value) => boxCurrentUser = value).asStream(),
      boxSessionRem().then((value) => boxRememberMe = value).asStream(),
      boxActivityA().then((value) => boxActivity = value).asStream(),
      boxAudioGuidesA().then((value) => boxAudioGuides = value).asStream(),
    ]).listen(
      (event) {
        print('YA TERMINO DE CARGAR ESTA VAINA ✅✅✅✅✅✅✅✅');
      },
      onDone: () => ready.add(true),
      onError: (error) => ready.add(false),
    );
  }

  static Future<Box<Person>> boxSession() async {
    try {
      print("=== Cargando BOX === ");
      box = await Hive.openBox('userdbB');
      print("✅ Box cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX === ");
      print(e);
      print("========================= ");
    }
    return box;
  }

  static Future<Box<CurrentUser>> boxSessionCurr() async {
    try {
      print("=== Cargando BOX === ");
      boxCurrentUser = await Hive.openBox('currentuserdbB');
      print("✅ Box cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX === ");
      print(e);
      print("========================= ");
    }
    return boxCurrentUser;
  }

  static Future<Box<RememberMe>> boxSessionRem() async {
    try {
      print("=== Cargando BOX === ");
      boxRememberMe = await Hive.openBox('rememberMedB');
      print("✅ Box rememberMedB cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX rememberMedB === ");
      print(e);
      print("========================= ");
    }
    return boxRememberMe;
  }

  // Se almamcena una persona, pero se divide en dos partes
  // En el box 'box' se almacena el objeto persona con detalle = null
  // y en el box 'boxAudioGuides' se almacena la lista de audioguias,
  // estas a la hora de consultarse en 'getFromBox' deben se consultadas
  // y unificadas para formar un soo objeto
  static void pushToBox(Person value, int key) async {
    List<dynamic> listAudioguides = value.detalle ?? [];
    value.detalle = null;
    await box.put(key, value);
    final encode = jsonEncode(listAudioguides);
    await boxAudioGuides.put(key, encode);
    print('✔ Se registra 0 con valor $value');
  }

  static Future<int> addToBox(Person value) async {
    var result = await box.add(value);
    print('✔ Se agrega usuario  valor $value');
    List<dynamic>? listAudioguides = value.detalle ?? [];
    await boxAudioGuides.put(result, listAudioguides);
    return result;
  }

  // Obtiene una persona almacenada en el box
  // Existen dos box:
  // 'box' contiene un objeto Persona
  // 'boxAudioGuides' contiene cadenas codificadas, que al decodificarlos almacenan objetos de tipo List<DataAudioGuideModel>
  // Al objeto Person, para el atributo detalle, se complementa consultando el box 'boxAudioGuides' para tener un
  // objeto persona completo
  static Person? getFromBox(int index) {
    final Person? person = box.get(index);
    if (person != null) {
      getListAudioguidesForDetailOfPerson(index, person);
    }
    print('✔ Se recupera con 0 el valor $person');
    print(person);

    return person;
  }

  static void getListAudioguidesForDetailOfPerson(int index, Person person) {
    if (boxAudioGuides.get(index) != null) {
      final s = boxAudioGuides.get(index);
      final decode = s != null
          ? s is List
              ? s
              : jsonDecode(s)
          : [];
      List<dynamic> value = (decode) as List<dynamic>;
      List<DataAudioGuideModel> resp =
          value.map((e) => DataAudioGuideModel.fromJson(e)).toList();
      person.detalle = resp;
    }
  }

  static Future<bool> existInBox(Person value) async {
    print("Person.id ${value}");
    bool exist = false;
    var filteredUsers =
        box.values.where((Person) => Person.id == value.id).toList();
    print(filteredUsers.asMap());

    if (filteredUsers.length > 0) {
      return !exist;
    } else {
      return exist;
    }
  }

  static Future<int> getIndex(Person value) async {
    var allUsers = box.values.toList();
    print('allusers $allUsers');
    final index = allUsers.indexWhere((element) => element.id == value.id);
    return index;
  }

/*  static Future<int> getListAudios(int index) async{

    final Person? person = await BoxDataSesion.getFromBox(index);

    var person = getFromBox(index);
    var allUsers = box.values.toList();
    print('allusers $allUsers');
    final index = allUsers.indexWhere((element) =>
    element.id == value.id);
    return index;
  }*/

  static bool get isLoggedIn {
    late bool value;
    late var data = null;
    try {
      data = getCurrentUser();
      print("data $data");
      if (data != null || data != '') {
        value = true;
      }
    } catch (e) {
      print("catch $data");
      value = false;
    }
    ;
    print("value $value");
    return value;
  }

  static void clearBox() {
    box.clear();
    box.deleteFromDisk();
    print("=== 🧹Box limpiada === ");
  }
//*********Para el usuario actual***************

  static void pushToBoxCurrentU(CurrentUser value) async {
    await boxCurrentUser.put(0, value);
    print('✔ Se registra current user con valor ${value}');
    print('✔ Se registra current user con valor de usuario ${value.id_user}');
    print('✔ Se registra current user con valor de usuario ${value.id_db}');
  }

  static CurrentUser? getCurrentUser() {
    final CurrentUser? value = boxCurrentUser.get(0);
    print('devuelve usuario actual ${value!.id_user}');
    return value;
  }

  static void clearBoxCurrentUser() {
    boxCurrentUser.delete(0);
    //boxCurrentUser.deleteFromDisk();
    print("=== 🧹Box Current USer limpiada === ");
  }

  //********************Para recordar Usuario**********************//
  static Future<int> addToRememberBox(dynamic value) async {
    var result = await boxRememberMe.add(value);
    print('✔ Se agrega usuario  valor $value');
    return result;
  }

  static RememberMe? getFromRememberBox(int index) {
    final RememberMe? value = boxRememberMe.get(index);
    print('✔ Se recupera con 0 el valor $value');
    print(value);
    return value;
  }

  static pushToRememberBox(dynamic value, int index) async {
    await boxRememberMe.putAt(index, value);
    print('✔ Se registra 0 con valor $value');
    return value;
  }

  static void clearBoxRememberMe() {
    boxRememberMe.deleteAll(boxRememberMe.keys);
    //boxCurrentUser.deleteFromDisk();
    print("=== 🧹Box Remember me limpiada === ");
  }

  static Future<Box<dynamic>> boxActivityA() async {
    try {
      print("=== Cargando BOX === ");
      boxActivity = await Hive.openBox('boxActivity');
      print("✅ Box de activity cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX activity === ");
      print(e);
      print("========================= ");
    }
    return boxActivity as Box<dynamic>;
  }

  static Future<Box<dynamic>> boxAudioGuidesA() async {
    try {
      print("=== Cargando BOX === ");
      boxAudioGuides = await Hive.openBox('boxAudioGuides');
      print("✅ Box de audioguias cargado");
      print("=================== ");
    } catch (e) {
      print("=== ❌ Error leyendo BOX audioguias === ");
      print(e);
      print("========================= ");
    }
    return boxAudioGuides;
  }

  static void pushToActivity(dynamic key, List<dynamic> value) {
    boxActivity.put(key, jsonEncode(value));
    print('✅ Se registra $key con valor ${jsonEncode(value)}');
  }

  static List<DataPlacesDetailModel> getListActivity(int idUser) {
    if (boxActivity.get(idUser) != null) {
      final s = boxActivity.get(idUser);
      final decode = jsonDecode(s);
      List<dynamic> value = (decode) as List<dynamic>;
      List<DataPlacesDetailModel> resp =
          value.map((e) => DataPlacesDetailModel.fromJson(e)).toList();
      return resp;
    }
    return [];
  }
}
