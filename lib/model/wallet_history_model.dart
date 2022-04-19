class WalletHistoryModel {
  const WalletHistoryModel({
    required this.title,
    required this.historyItemList,
  });

  final String title;
  final List<HistoryItem> historyItemList;

  static fromJson(responseJson) {
    return null;
  }
}

class HistoryItem {
  const HistoryItem({
    required this.title,
    required this.date,
    required this.isSuccess,
    required this.successText,
  });

  final String title;
  final String date;
  final bool isSuccess;
  final String successText;

  static fromJson(responseJson) {
    return null;
  }
}
