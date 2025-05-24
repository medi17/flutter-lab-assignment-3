import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/albums',
    routes: [
      GoRoute(
        path: '/albums',
        name: 'albums',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: 'album-detail',
        builder: (context, state) {
          final albumId = int.parse(state.pathParameters['id'] ?? '0');
          return AlbumDetailScreen(albumId: albumId);
        },
      ),
    ],
  );

  static void navigateToAlbums(BuildContext context) {
    context.goNamed('albums');
  }

  static void navigateToAlbumDetail(BuildContext context, int albumId) {
    context.pushNamed('album-detail', pathParameters: {'id': albumId.toString()});
  }

  static void navigateToHome(BuildContext context) {
    context.goNamed('albums');
  }
} 