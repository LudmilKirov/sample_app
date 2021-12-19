import 'package:support_desk/data/services/users/model/user_model.dart';
import 'package:support_desk/utils/app_util.dart';
import 'package:test/test.dart';

void main() {
  test('test getNameToShowForTheUser', () async {
    User user = User(firstName: '', lastName: '', available: false, phone: '');

    //Both empty
    String result = AppUtil.getNameToShowForTheUser(user);
    expect(result, ' ');

    //First name empty only
    User user1 = user.copyWith(lastName: 'lastName');

    result = AppUtil.getNameToShowForTheUser(user1);
    expect(result, ' lastName');

    //Last name empty only
    User user2 = user.copyWith(firstName: 'firstName');

    result = AppUtil.getNameToShowForTheUser(user2);
    expect(result, 'firstName ');

    //First name and Last name available
    User user3 = user.copyWith(firstName: 'firstName', lastName: 'lastName');

    result = AppUtil.getNameToShowForTheUser(user3);
    expect(result, 'firstName lastName');
  });
}
