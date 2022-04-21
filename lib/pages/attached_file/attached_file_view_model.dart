import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/attached_file/attached_file_status.dart';
import 'package:localdaily/pages/attached_file/attahced_file_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachedFileViewModel
    extends EffectsViewModel<AttachedFileStatus, AttachedFileEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  late dynamic item;
  late bool isBuy;

  AttachedFileViewModel(
    this._router,
    this._interactor,
    this.item, {
    required this.isBuy,
  }) {
    status = AttachedFileStatus(
      isLoading: false,
      isError: true,
      item: item,
      dateOfExpire: '',
      isBuy: isBuy,
    );
  }

  Future<void> onInit(BuildContext context) async {
    status = status.copyWith(item: item, isBuy: isBuy);

    final bool next = await LdConnection.validateConnection();

    if (next) {
    } else {
      // TODO: Mostrar alerta
    }
  }

  attachFile(String AdvertisementId, String UserId, BuildContext context) {
    if (status.file == null) {
      print(' no se pudo enviar');
      addEffect(
        ShowSnackbarErrorEffect(
          'No se pudo cargar la imagen, intetalo nuevamente',
        ),
      );
      return;
    }
    status = status.copyWith(isLoading: true);
    addEffect(ShowLoadingEffect());
    try {
      _interactor
          .sendAttach(
              AdvertisementId: AdvertisementId,
              xFile: status.file!,
              UserId: UserId)
          .then((response) {
        status = status.copyWith(isLoading: false);
        closeDialog(context);
        closeDialog(context);
        _router.goDetailOperOffer(context, replace: true);

        if (response.isSuccess) {
          addEffect(ShowSnackbarSuccesEffect());
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

  void getPhotoCamera(ImagePicker _picker) async {
    XFile? _xfile = await _picker.pickImage(source: ImageSource.camera);
    status = status.copyWith(
      file: _xfile,
      filePath: _xfile?.path,
    );
  }

  void getPhotoGallery(ImagePicker _picker) async {
    XFile? _xfile = await _picker.pickImage(source: ImageSource.gallery);
    status = status.copyWith(
      file: _xfile,
      filePath: _xfile?.path,
    );
  }

  Future<PermissionStatus> handlePermisos() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
      print('Permiso denegado a la camara ${status.isPermanentlyDenied}');
    }

    return status;
  }

  void closeDialog(BuildContext context) {
    _router.pop(context);
  }
}
