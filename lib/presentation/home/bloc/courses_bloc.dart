import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/courses_model.dart';
import '../../../data/repository/courses_repository.dart';

abstract class CoursesEvent {}

class LoadCourses extends CoursesEvent {}

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<CoursesModel> courses;
  CoursesLoaded(this.courses);
}

class CoursesError extends CoursesState {}

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CoursesRepository repository;

  CoursesBloc(this.repository) : super(CoursesInitial()) {
    on<LoadCourses>((event, emit) async {
      emit(CoursesLoading());
      try {
        final courses = await repository.fetchCourses();
        emit(CoursesLoaded(courses));
      } catch (e) {
        emit(CoursesError());
      }
    });
  }
}
