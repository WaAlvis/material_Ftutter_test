import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_status.dart';
import 'package:bogota_app/utils/errors/user_data_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';
import 'package:hive/hive.dart';

class ProfileViewModel extends ViewModel<ProfileStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  ProfileViewModel(this._route, this._interactor) {
    status = ProfileStatus(
      titleBar: 'Recibidos',
      isLoading: false,
      openMenu: false,
      dataUser: null,

    );
  }


  void onInit() async {
    getDataUser();
  }

  Future<String> getNameUser() async {
    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    final Person? person = await BoxDataSesion.getFromBox(user.id_db!);
    print("person?.name  ${person?.name }");
    return person?.name ?? '-';
  }

  void getDataUser() async {

    CurrentUser user = BoxDataSesion.getCurrentUser()!;
    final Person? person = await BoxDataSesion.getFromBox(user.id_db!);
    var idUser = person!.id.toString();
    print('obteniendo datos del Usuario');
    final dataUser = await _interactor.getDataUser(idUser);
    if (dataUser is IdtSuccess<UserModel?>) {
      print('Email del Usario id $idUser:** ${dataUser.body!.name}');

      status = status.copyWith(dataUser: dataUser.body); // Status reasignacion
    } else {
      final erroRes = dataUser as IdtFailure<UserDataError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void goProfileEditPage() async {
    status = status.copyWith(isLoading: true);
    await _route.goProfileEdit(status.dataUser!);
    status = status.copyWith(isLoading: false);
  }

  void goSettingPage() {
    _route.goSettings();
  }
  Future<bool> offMenuBack()async {
    bool? shouldPop = true;

    if (status.openMenu) {
      openMenu();
      return !shouldPop;
    } else {
      return shouldPop;
    }
  }
}
