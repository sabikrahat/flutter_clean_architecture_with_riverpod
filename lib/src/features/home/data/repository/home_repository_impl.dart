import '../../domain/repository/home_repository.dart';
import '../sources/remote/home_remote_service.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteService _homeRemoteService;

  HomeRepositoryImpl(this._homeRemoteService);
}
