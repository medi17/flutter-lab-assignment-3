import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logic/album_bloc.dart';
import 'router/app_router.dart';
import 'services/api_service.dart';
import 'data/repositories/album_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final albumRepository = AlbumRepository(apiService: apiService);

    return BlocProvider(
      create: (context) => AlbumCubit(albumRepository)..loadAlbums(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Album Viewer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4), // Purple primary color
            secondary: const Color(0xFF625B71), // Deep purple secondary
            tertiary: const Color(0xFF7D5260), // Mauve tertiary
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: const Color(0xFF6750A4),
            foregroundColor: Colors.white,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
