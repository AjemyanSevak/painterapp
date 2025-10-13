import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:painter_app/core/injector/injector.dart';
import 'package:painter_app/firebase/image/image_repository.dart';
import 'package:painter_app/models/image/image_model.dart';

part 'home_cubit.g.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({ImageRepository? repo})
    : _repo = repo ?? sl(),
      super(HomeState.initial());

  final ImageRepository _repo;

  Stream<List<ImageDoc>> streamUserImages() => _repo.imagesStream();

  void setCreateButtonVisible(bool visible) async {
    emit(state.rebuild((s) => s..createButtonVisible = visible));
  }
}
