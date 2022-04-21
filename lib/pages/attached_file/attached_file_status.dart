import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:localdaily/view_model.dart';

class AttachedFileStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final dynamic item;
  final String dateOfExpire;
  final bool isBuy;
  final XFile? file;
  final String? filePath;

  AttachedFileStatus({
    this.file,
    this.filePath,
    required this.dateOfExpire,
    required this.isLoading,
    required this.isError,
    required this.item,
    required this.isBuy,
  });

  AttachedFileStatus copyWith({
    String? dateOfExpire,
    bool? isLoading,
    bool? isError,
    dynamic? item,
    bool? isBuy,
    XFile? file,
    String? filePath,
  }) {
    return AttachedFileStatus(
      item: item ?? this.item,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      dateOfExpire: dateOfExpire ?? this.dateOfExpire,
      isBuy: isBuy ?? this.isBuy,
      file: file ?? this.file,
      filePath: filePath ?? filePath,
    );
  }
}
