import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/view_model.dart';

class DetailOfferStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Data item;
  final String dateOfExpire;
  final bool isBuy;
  // Bank information
  ResultGetBanks listBanks;
  ResultGetDocsType listDocsType;
  ResultGetDocsType
      listAccountType; //cambiar el tipo cuando se consuma el servicio
  final Bank? selectedBank;
  final DocType? selectedDocType;
  final DocType?
      selectedAccountType; //cambiar el tipo cuando se consuma el servicio

  DetailOfferStatus({
    required this.dateOfExpire,
    required this.isLoading,
    required this.isError,
    required this.item,
    required this.isBuy,
    required this.listBanks,
    required this.listDocsType,
    required this.selectedBank,
    required this.listAccountType,
    required this.selectedDocType,
    required this.selectedAccountType,
  });

  DetailOfferStatus copyWith({
    String? dateOfExpire,
    bool? isLoading,
    bool? isError,
    Data? item,
    bool? isBuy,
    ResultGetBanks? listBanks,
    ResultGetDocsType? listDocsType,
    ResultGetDocsType? listAccountType,
    Bank? selectedBank,
    DocType? selectedDocType,
    DocType? selectedAccountType,
  }) {
    return DetailOfferStatus(
      item: item ?? this.item,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      dateOfExpire: dateOfExpire ?? this.dateOfExpire,
      isBuy: isBuy ?? this.isBuy,
      listBanks: listBanks ?? this.listBanks,
      listDocsType: listDocsType ?? this.listDocsType,
      selectedBank: selectedBank ?? this.selectedBank,
      listAccountType: listAccountType ?? this.listAccountType,
      selectedDocType: selectedDocType ?? this.selectedDocType,
      selectedAccountType: selectedAccountType ?? this.selectedAccountType,
    );
  }
}