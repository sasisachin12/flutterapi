class DataClass {
    String amount;
    String avatar;
    String date;
    int id;
    String name;

    DataClass({required this.amount, required this.avatar, required this.date, required this.id, required this.name});

    factory DataClass.fromJson(Map<String, dynamic> json) {
        return DataClass(
            amount: json['amount'], 
            avatar: json['avatar'], 
            date: json['date'], 
            id: json['id'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['avatar'] = this.avatar;
        data['date'] = this.date;
        data['id'] = this.id;
        data['name'] = this.name;
        return data;
    }

    static List<DataClass> fromJsonList(dynamic jsonList) {
        final transactionDetailsList = <DataClass>[];
        if (jsonList == null) return transactionDetailsList;

        if (jsonList is List<dynamic>) {
            for (final json in jsonList) {
                transactionDetailsList.add(
                    DataClass.fromJson(json),
                );
            }
        }

        return transactionDetailsList;
    }
}