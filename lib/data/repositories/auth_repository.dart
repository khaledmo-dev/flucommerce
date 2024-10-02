import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:collection/collection.dart';
import 'package:flucommerce/services/client_service.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

abstract class AuthRepository {
  bool isLoggedIn();

  bool isGuest();

  String? authToken();

  User? getSignedInUser();

  Future<Either<AppException, Unit>> register({
    required String emailAddress,
    required String password,
    required String userName,
  });

  Future<Either<AppException, Unit>> setupAccount({required User user});

  Future<Either<AppException, Unit>> signInWithEmailAndPassword({
    required String userName,
    required String password,
  });

  Future<Either<AppException, User>> getUserDetails();

  void logout();

  Future<Either<AppException, Unit>> validateToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final _client = locator<ClientService>();
  final _localStorage = locator<LocalStorageService>();

  var logger = getLogger("AuthRepositoryImpl");

  @override
  String? authToken() {
    return _localStorage.token;
  }

  @override
  User? getSignedInUser() {
    return _localStorage.user;
  }

  @override
  bool isLoggedIn() => _localStorage.user != null;

  @override
  void logout() {
    _localStorage.user = null;
    _localStorage.token = null;
  }

  @override
  Future<Either<AppException, Unit>> register({
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    try {
      // Check if the email is already taken
      var userResponse =
          await _client.get(api: "${AppConstants.userUrl}?email=$emailAddress");

      List<User> userResult = userFromJson(userResponse);

      if (userResult.isNotEmpty) {
        logger.e("email-already-taken");
        return Left(AppException(body: "email-already-taken"));
      }

      // check if the userName is already taken

      var usernameReponse =
          await _client.get(api: "${AppConstants.userUrl}?search=$userName");

      List<User> userNameResult = userFromJson(usernameReponse);

      if (userNameResult.firstWhereOrNull((element) =>
              element.username.toLowerCase() == userName.toLowerCase()) !=
          null) {
        logger.e("username-already-taken");
        return Left(AppException(body: "username-already-taken"));
      }

      // if everything checks out and the email and userName are not taken then add the customer to the database

      var registeredUser = await _client.post(
        api: AppConstants.userUrl,
        body: {
          'email': emailAddress,
          'username': userName,
          'password': password,
          'billing': {'email': emailAddress},
          'shipping': {'email': emailAddress}
        },
      );

      var auth = await _client.post(
        api: AppConstants.loginUrl,
        body: {
          "username": userName,
          "password": password,
        },
      );

      _localStorage.token = auth["token"];

      _localStorage.user = User.fromJson(registeredUser);
      // _localStorage.isGuest = false;
      return const Right(unit);
    } catch (e) {
      logger.wtf(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> setupAccount({required User user}) async {
    try {
      var updatedUser = await _client.put(
        api: "${AppConstants.userUrl}/${user.id}",
        body: user.toJson(),
      );

      logger.w(updatedUser);

      _localStorage.user = User.fromJson(updatedUser);

      return const Right(unit);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> signInWithEmailAndPassword(
      {required String userName, required String password}) async {
    try {
      var auth = await _client.post(
        api: AppConstants.loginUrl,
        body: {
          "username": userName,
          "password": password,
        },
      );

      var email = auth["user_email"];

      var usersReponse =
          await _client.get(api: "${AppConstants.userUrl}?email=$email");

      User user = userFromJson(usersReponse).first;

      _localStorage.token = auth["token"];

      _localStorage.user = user;

      // _localStorage.isGuest = false;

      return const Right(unit);
    } catch (e) {
      logger.e(e);

      logger.e('$e');
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  bool isGuest() {
    return _localStorage.user == null;
  }

  @override
  Future<Either<AppException, Unit>> validateToken() async {
    try {
      if (_localStorage.token == null) {
        return Left(AppException(body: "NO-TOKEN"));
      }

      var response = await http.post(
        Uri.parse(AppConstants.validateTokenUrl),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "Bearer ${_localStorage.token} "
        },
      );
      logger.e(jsonDecode(response.body));
      logger.wtf(_localStorage.token);

      if (jsonDecode(response.body)["code"] == "jwt_auth_valid_token") {
        logger.wtf("VALID TOKEN");
        return const Right(unit);
      } else {
        logger.e("INVALID TOKEN");
        return Left(AppException(body: "INVALID TOKEN"));
      }
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, User>> getUserDetails() async {
    try {
      var response = await _client.get(
          api: "${AppConstants.userUrl}/${_localStorage.user?.id}");

      var user = User.fromJson(response);

      _localStorage.user = user;

      return Right(user);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }
}
