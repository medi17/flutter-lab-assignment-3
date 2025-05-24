import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../data/repositories/album_repository.dart';

// Events
abstract class AlbumEvent {}

class LoadAlbums extends AlbumEvent {}

class LoadAlbumDetail extends AlbumEvent {
  final int albumId;
  LoadAlbumDetail(this.albumId);
}

// States
abstract class AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;

  AlbumLoaded(this.albums, this.photos);
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

// Cubit
class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository _repository;

  AlbumCubit(this._repository) : super(AlbumLoading());

  Future<void> loadAlbums() async {
    try {
      emit(AlbumLoading());
      final albums = await _repository.fetchAlbums();
      final photos = await _repository.fetchPhotos();
      emit(AlbumLoaded(albums, photos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> loadAlbumDetail(int albumId) async {
    try {
      emit(AlbumLoading());
      final albums = await _repository.fetchAlbums();
      final photos = await _repository.fetchPhotosByAlbumId(albumId);
      emit(AlbumLoaded(albums, photos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _repository.dispose();
    return super.close();
  }
}
