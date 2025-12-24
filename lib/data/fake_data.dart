import '../models/account.dart';

class FakeData {
  static List<Account> accounts = [
    Account(id: '1234 5678 9012 3456',
        type: 'جاری',
        balance: 12500000,
    ),
    Account(id: '9876 5432 1098 7654',
        type: 'پس انداز',
        balance: 4200000,
    ),
  ];
}