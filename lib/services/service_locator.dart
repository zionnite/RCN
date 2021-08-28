import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/services/audio_handler.dart';
import 'package:rcn/services/playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
