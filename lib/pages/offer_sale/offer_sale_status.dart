import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/view_model.dart';

class OfferSaleStatus extends ViewStatus {
  final String costDLYtoCOP;
  final String feeMoney;
  final String totalMoney;
  final bool isAccountNumEmpty;
  final bool isDocNumUserEmpty;
  final bool isNameTitularAccountEmpty;
  final bool isLoading;
  final bool isError;
  final bool isMarginEmpty;
  ResultGetBanks listBanks;
  ResultGetDocsType listDocsType;
  List<AccountType> listAccountType;
  final Bank? selectedBank;
  final DocType? selectedDocType;
  final AccountType? selectedAccountType;

  OfferSaleStatus({
    required this.isAccountNumEmpty,
    required this.isNameTitularAccountEmpty,
    required this.isDocNumUserEmpty,
    required this.costDLYtoCOP,
    required this.isMarginEmpty,
    required this.feeMoney,
    required this.totalMoney,
    required this.isLoading,
    required this.isError,
    required this.listBanks,
    required this.listDocsType,
    required this.selectedBank,
    required this.listAccountType,
    required this.selectedDocType,
    required this.selectedAccountType,
  });

  OfferSaleStatus copyWith({
    bool? isMarginEmpty,
    String? costDLYtoCOP,
    String? feeMoney,
    String? totalMoney,
    bool? isLoading,
    bool? isAccountNumEmpty,
    bool? isNameTitularAccountEmpty,
    bool? isDocNumUserEmpty,
    bool? isError,
    ResultGetBanks? listBanks,
    ResultGetDocsType? listDocsType,
    List<AccountType>? listAccountType,
    Bank? selectedBank,
    DocType? selectedDocType,
    AccountType? selectedAccountType,
  }) {
    return OfferSaleStatus(
      isNameTitularAccountEmpty:
          isNameTitularAccountEmpty ?? this.isNameTitularAccountEmpty,
      isDocNumUserEmpty: isDocNumUserEmpty ?? this.isDocNumUserEmpty,
      isAccountNumEmpty: isAccountNumEmpty ?? this.isAccountNumEmpty,
      isMarginEmpty: isMarginEmpty ?? this.isMarginEmpty,
      costDLYtoCOP: costDLYtoCOP ?? this.costDLYtoCOP,
      feeMoney: feeMoney ?? this.feeMoney,
      totalMoney: totalMoney ?? this.totalMoney,
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
