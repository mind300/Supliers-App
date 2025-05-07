import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/about_feature/data/repo/about_repo.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit(this.aboutRepo) : super(AboutInitial());
  final AboutRepo aboutRepo;

  getAbout() async {
    emit(AboutLoading());
    final result = await aboutRepo.getAbout();
    result.fold(
      (l) => emit(AboutError(l.message)),
      (r) => emit(AboutSuccess(r)),
    );
  }
}
