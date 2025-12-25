import '../models/account.dart';
import '../models/user.dart';

class FakeData {
  //مشخصات حساب ها
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
  //یوزر ها
  static List<User> users = [
    User(
      name: 'کیانا ارجمند',
      username: 'kiana_arjmand',
    ),
    User(
      name: 'ایلیا فلاح',
      username: 'ilia_fallah'
    ),
  ];
  //یوزر فعال
  static User currentUser = users[0];
}