// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

/*
* * Use for Fetching data
* * Return State => UserState
*/
class UserListFetchEv extends UserEvent {
  const UserListFetchEv({
    this.name,
    this.city,
  });

  final String? name;
  final String? city;

  @override
  String toString() => 'UserEvent.UserFetchEv: { name: $name, city: $city }';

  @override
  List<Object> get props => [];
}

class AddUserEv extends UserEvent {
  const AddUserEv({
    this.name,
    this.email,
    this.city,
    this.address,
    this.phoneNumber,
  });

  final String? name;
  final String? email;
  final String? city;
  final String? address;
  final String? phoneNumber;

  @override
  String toString() => 'UserEvent.UserFetchEv: { name: $name, city: $city }';

  @override
  List<Object> get props => [];
}
