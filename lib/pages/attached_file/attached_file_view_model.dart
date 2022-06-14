import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/attached_file/attached_file_status.dart';
import 'package:localdaily/pages/attached_file/attahced_file_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AttachedFileViewModel
    extends EffectsViewModel<AttachedFileStatus, AttachedFileEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  late String item;
  late bool isBuy;
  late String isOper;
  final String offerId;
  final String extensionFile;
  final String isView2;

  AttachedFileViewModel(
    this._router,
    this._interactor,
    this.item,
    this.extensionFile, {
    required this.isBuy,
    required this.isOper,
    required this.offerId,
    required this.isView2,
  }) {
    status = AttachedFileStatus(
      isLoading: false,
      isError: true,
      item: item,
      dateOfExpire: '',
      isBuy: isBuy,
      // isOper: isOper,
      userId: '',
      offerId: offerId,
      extensionFile: extensionFile,
      isView: isView2,
      bytes: null,
      extensionUrl: '',
    );
  }

  Future<void> onInit(
      BuildContext context, DataUserProvider dataUserProvider) async {
    status = status.copyWith(item: item, isBuy: isBuy);
    status = status.copyWith(isLoading: true);
    addEffect(ShowLoadingEffect());
    status = status.copyWith(userId: dataUserProvider.getDataUserLogged!.id);
    final bool next = await LdConnection.validateConnection();

    if (next) {
      try {
        final DataUserProvider dataUserProvider =
            context.read<DataUserProvider>();

        final token = dataUserProvider.getTokenLogin;
        await _interactor
            .getAttachFile('$offerId$extensionFile', 'Bearer ${token!.token}')
            .then((response) {
          final Uint8List bytesFile = base64.decode(response.result.toString());
          status = status.copyWith(bytes: bytesFile);
        });
        status = status.copyWith(isLoading: false);
        closeDialog(context);
      } catch (e) {
        status = status.copyWith(isLoading: false);
        closeDialog(context);
      }

      // status = status.copyWith(isLoading: false);

    } else {
      status = status.copyWith(isLoading: false);

      // TODO: Mostrar alerta
    }
  }

  attachFile(String AdvertisementId, String UserId, BuildContext context) {
    if (status.file == null) {
      addEffect(
        ShowSnackbarErrorEffect(
          'No se pudo cargar el archivo, intetalo nuevamente',
        ),
      );
      return;
    }
    status = status.copyWith(isLoading: true);
    addEffect(ShowLoadingEffect());
    try {
      final DataUserProvider dataUserProvider =
          context.read<DataUserProvider>();

      final token = dataUserProvider.getTokenLogin;
      _interactor
          .sendAttach(
              AdvertisementId: offerId,
              xFile: status.file!,
              UserId: UserId,
              headers: 'Bearer ${token!.token}')
          .then((response) {
        status = status.copyWith(isLoading: false);
        closeDialog(context);
        closeDialog(context);
        _router.goDetailOperOffer(context, AdvertisementId, isOper,
            replace: true);

        if (response.isSuccess) {
          addEffect(
              ShowSnackbarSuccesEffect('Se envio exitosamente el archivo'));
        } else {
          addEffect(
            ShowSnackbarErrorEffect(response.error!.message),
          ); //cambiar mensaje
        }
      });
    } catch (e) {
      status = status.copyWith(isLoading: false);
      closeDialog(context);

      addEffect(ShowSnackbarErrorEffect('Error desconocdio')); //cambiar mensaje
    }
  }

  void getPhotoCamera(ImagePicker _picker, BuildContext context) async {
    XFile? _xfile = await _picker.pickImage(source: ImageSource.camera);
    status = status.copyWith(
      file: _xfile,
      filePath: _xfile?.path,
    );
    closeDialog(context);
  }

  void getPhotoGallery(ImagePicker _picker) async {
    XFile? _xfile = await _picker.pickImage(source: ImageSource.gallery);
    status = status.copyWith(
      file: _xfile,
      filePath: _xfile?.path,
    );
  }

  void getFile(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['jpg', 'pdf', 'png', 'jpeg'],
    );

    if (result != null) {
      final XFile file = XFile(result.files.single.path!);
      status = status.copyWith(extensionUrl: result.files.first.extension);
      status = status.copyWith(file: file);
      status = status.copyWith(filePath: file.path);

      closeDialog(context);
    } else {
      // User canceled the picker
      closeDialog(context);
    }
  }

  Future<PermissionStatus> handlePermisos() async {
    Permission.camera.request();
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }

    return status;
  }

  void saveFile(Uint8List docFile) async {
    status = status.copyWith(isLoading: true);
    final bool statusstorage = await Permission.storage.isGranted;
    if (!statusstorage) {
      Permission.storage.request();
    }

    try {
      // Directory dir = await getDownloadsDirectory();

      final Directory? dir = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      final File file = File(
        '${dir!.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.pdf',
      );
      await file.writeAsBytes(docFile);

      addEffect(
        ShowSnackbarSuccesEffect(
          'Archivo guardado exitosamente en: ${file.path}',
        ),
      );
      Uint8List contents = await file.readAsBytes();
      status = status.copyWith(isLoading: false);
      try {
        OpenFile.open(file.path);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      // addEffect(
      //   ShowSnackbarErrorEffect('$e Error desconocdio'),
      // );
      print(e);
      status = status.copyWith(isLoading: false);
    }
  }

  void closeDialog(BuildContext context) {
    _router.pop(context);
  }
}
