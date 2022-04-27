import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:localdaily/view_model.dart';

class AttachedFileStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final String item;
  final String dateOfExpire;
  final bool isBuy;
  final XFile? file;
  final String? filePath;
  final bool? isOper;
  final String? userId;
  final String? offerId;
  final String? extensionFile;
  final Uint8List? bytes;
  final String? isView;

  AttachedFileStatus({
    this.file,
    this.filePath,
    required this.dateOfExpire,
    required this.isLoading,
    required this.isError,
    required this.item,
    required this.isBuy,
    required this.isOper,
    required this.userId,
    required this.offerId,
    required this.extensionFile,
    required this.bytes,
    required this.isView,
  });

  AttachedFileStatus copyWith({
    String? dateOfExpire,
    bool? isLoading,
    bool? isError,
    String? item,
    bool? isBuy,
    XFile? file,
    String? filePath,
    bool? isOper,
    String? userId,
    String? offerId,
    String? extensionFile,
    Uint8List? bytes,
    String? isView,
  }) {
    return AttachedFileStatus(
        item: item ?? this.item,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        dateOfExpire: dateOfExpire ?? this.dateOfExpire,
        isBuy: isBuy ?? this.isBuy,
        file: file ?? this.file,
        filePath: filePath ?? this.filePath,
        isOper: isOper ?? this.isOper,
        userId: userId ?? this.userId,
        offerId: offerId ?? this.offerId,
        extensionFile: extensionFile ?? this.extensionFile,
        bytes: bytes ?? this.bytes,
        isView: isView ?? this.isView);
  }
}
