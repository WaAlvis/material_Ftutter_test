import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offerts/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/view_model.dart';

class OffertSaleStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;
  ResultGetDocsType listDocsType;
  ResultGetDocsType
      listAccountType; //cambiar el tipo cuando se consuma el servicio
  final Bank? selectedBank;
  final DocType? selectedDocType;
  final DocType?
      selectedAccountType; //cambiar el tipo cuando se consuma el servicio

  OffertSaleStatus({
    required this.isLoading,
    required this.isError,
    required this.listBanks,
    required this.listDocsType,
    required this.selectedBank,
    required this.listAccountType,
    required this.selectedDocType,
    required this.selectedAccountType,
  });

  OffertSaleStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultGetBanks? listBanks,
    ResultGetDocsType? listDocsType,
    ResultGetDocsType? listAccountType,
    Bank? selectedBank,
    DocType? selectedDocType,
    DocType? selectedAccountType,
  }) {
    return OffertSaleStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
      listDocsType: listDocsType ?? this.listDocsType,
      selectedBank: selectedBank ?? this.selectedBank,
      listAccountType: listAccountType ?? this.listAccountType,
      selectedDocType: selectedDocType ?? this.selectedDocType,
      selectedAccountType: selectedAccountType ?? this.selectedAccountType,
    );
  }
}
