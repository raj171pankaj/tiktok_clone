import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _serachedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _serachedUsers.value;

  searchUser(String typedUser) async {
    _serachedUsers.bindStream(
      firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            retVal.add(User.fromSnap(elem));
          }
          return retVal;
        },
      ),
    );
  }
}
