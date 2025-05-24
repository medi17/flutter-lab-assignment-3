import '../../models/album.dart';
import '../../models/photo.dart';
import '../../services/api_service.dart';

class AlbumRepository {
  final ApiService _apiService;
  List<Album>? _cachedAlbums;
  List<Photo>? _cachedPhotos;

  AlbumRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Album>> fetchAlbums() async {
    if (_cachedAlbums != null) {
      return _cachedAlbums!;
    }
    final albums = a wait _apiService.getAlbums();
    _cachedAlbums = albums;
    return albums;
  }

  Future<List<Photo>> fetchPhotos() async {
    if (_cachedPhotos != null) {
      return _cachedPhotos!;
    }
    final photos = await _apiService.getPhotos();
    _cachedPhotos = photos;
    return photos;
  }

  Future<List<Photo>> fetchPhotosByAlbumId(int albumId) async {
    if (_cachedPhotos != null) {
      return _cachedPhotos!.where((photo) => photo.albumId == albumId).toList();
    }
    return await _apiService.getPhotosByAlbumId(albumId);
  }

  void clearCache() {
    _cachedAlbums = null;
    _cachedPhotos = null;
  }

  void dispose() {
    clearCache();
    _apiService.dispose();
  }
}
