import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchEvolution extends DetailEvent {
  final List<String> ids;
  const FetchEvolution(this.ids);

  @override
  List<Object?> get props => [ids];
}
