import 'package:get/get.dart';
import 'package:support_desk/data/repositories/users/users_repository.dart';
import 'package:support_desk/data/services/users/user_service.dart';
import 'package:support_desk/ui/support_desk/support_desk_list_view_controller.dart';
import 'package:support_desk/ui/support_desk/user_detail/user_details_controller.dart';

void inject() {
  // Repositories
  Get.lazyPut<UsersRepository>(() => UsersRepositoryImpl(Get.find()), fenix: true);
  Get.lazyPut<UsersService>(() => UsersServiceImpl(), fenix: true);

  // Controllers
  Get.lazyPut(() => SupportDeskController(), fenix: true);
  Get.lazyPut(() => UserDetailsController(), fenix: true);
}
