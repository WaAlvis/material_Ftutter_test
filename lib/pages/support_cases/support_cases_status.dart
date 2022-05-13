import 'package:localdaily/services/models/support_cases/result_support_cases.dart';
import 'package:localdaily/view_model.dart';

class SupportCasesStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final ResultSupportCases resultSupportCases;

  SupportCasesStatus({
    required this.isLoading,
    required this.isError,
    required this.resultSupportCases,
  });

  SupportCasesStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultSupportCases? resultSupportCases,
  }) {
    return SupportCasesStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      resultSupportCases: resultSupportCases ?? this.resultSupportCases,
    );
  }
}
