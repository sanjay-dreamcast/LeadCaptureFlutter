import 'package:contacts_service/contacts_service.dart';
import 'package:cphi/view/Dashboard/dashboardView.dart';
import 'package:cphi/view/Home/homeView.dart';
import 'package:cphi/view/events/events_Screen.dart';
import 'package:cphi/view/localDatabase/addContactPage.dart';
import 'package:get/get.dart';
import '../splash/splash_binding.dart';
import '../splash/splash_page.dart';
import '../view/localDatabase/LocalContactPage.dart';
import '../view/localDatabase/contactDetailPage.dart';
import '../view/qrCode/view/camera_qr.dart';
import '../view/qrCode/view/main_qr.dart';
import '../view/qrCode/view/qr_profile_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => SplashScreen(),
        binding: SplashBinding()),

    GetPage(
        name: LocalContactViewPage.routeName,
        page: () => LocalContactViewPage()),

    GetPage(name: DashboardPage.routeName, page: () => DashboardPage()),
    GetPage(name: QrProfilePage.routeName, page: () => QrProfilePage()),
    GetPage(name: QRScanner.routeName, page: () => QRScanner()),

    GetPage(name: HomePgae.routeName, page: () => HomePgae()),

    GetPage(
        name: AddContactView.routeName,
        page: () => AddContactView(
              contact: Contact(),
            )),

    GetPage(
        name: ContactDetailPage.routeName,
        page: () => ContactDetailPage(
              id: "0",
              index: 0,
            )),

    // GetPage(name: SignupPage.routeName, page: () => SignupPage()),

    GetPage(name: QRScanner.routeName, page: () => QRScanner()),
    GetPage(name: EventsScreen.routeName, page: () => EventsScreen()),

    // GetPage(name: ChatDetailPage.routeName, page: () => ChatDetailPage()),
  ];
}
