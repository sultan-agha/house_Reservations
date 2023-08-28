// here we have all the model and info
// create the data base in build in the the firebox(named as firestore database)
// add the rule in cloud firestore infront of allow read,write: if request.auth!=null
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? lastName;


  UserModel({this.uid,this.email,this.firstName,this.lastName});
// factory is to create new instance
  //recieving data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
  return{
  'uid': uid,
  'email': email,
  'firstName': firstName,
  'lastName': lastName,
  };
}


}