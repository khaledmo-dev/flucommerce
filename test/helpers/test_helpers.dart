import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flucommerce/services/client_service.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flucommerce/services/theme_service.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/services/flash_message_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ClientService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<LocalStorageService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TranslationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FlashMessageService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterClientService();
  getAndRegisterLocalStorageService();
  getAndRegisterThemeService();
  getAndRegisterTranslationService();
  getAndRegisterFlashMessageService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockClientService getAndRegisterClientService() {
  _removeRegistrationIfExists<ClientService>();
  final service = MockClientService();
  locator.registerSingleton<ClientService>(service);
  return service;
}

MockLocalStorageService getAndRegisterLocalStorageService() {
  _removeRegistrationIfExists<LocalStorageService>();
  final service = MockLocalStorageService();
  locator.registerSingleton<LocalStorageService>(service);
  return service;
}

MockThemeService getAndRegisterThemeService() {
  _removeRegistrationIfExists<ThemeService>();
  final service = MockThemeService();
  locator.registerSingleton<ThemeService>(service);
  return service;
}

MockTranslationService getAndRegisterTranslationService() {
  _removeRegistrationIfExists<TranslationService>();
  final service = MockTranslationService();
  locator.registerSingleton<TranslationService>(service);
  return service;
}

MockFlashMessageService getAndRegisterFlashMessageService() {
  _removeRegistrationIfExists<FlashMessageService>();
  final service = MockFlashMessageService();
  locator.registerSingleton<FlashMessageService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
