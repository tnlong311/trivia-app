import 'package:get/get.dart';

// getx page transition
Future<T?> customGetTo<T>(dynamic page, {dynamic arguments}) async {
  return await Get.off<T>(
    page,
    arguments: arguments,
    transition: Transition.rightToLeft,
    duration: const Duration(milliseconds: 400),
  );
}
