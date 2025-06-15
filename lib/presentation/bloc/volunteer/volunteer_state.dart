part of 'volunteer_bloc.dart';

sealed class VolunteerState extends Equatable {
  const VolunteerState();
  
  @override
  List<Object> get props => [];
}

final class VolunteerInitial extends VolunteerState {}
