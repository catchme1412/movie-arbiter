import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  GoogleSignIn _googleSignIn;

  GoogleAuth() {
    _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
  }
  static final GoogleAuth _singleton = new GoogleAuth();
//  MovieAppContext._internal();

  static GoogleAuth getInstance() => _singleton;

  void login() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//      setState(() {
//        isLoggedIn = true;
//        print("LOGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
//        sharedPreferences.setBool(MovieAppContext.IS_LOGGED_IN, true);
//        sharedPreferences.setString(
//            MovieAppContext.USER_NAME, googleSignInAccount.displayName);
//        print(googleSignInAccount.displayName);
//        MovieNavigator.navigate(context, MovieListingPage.ROUTE);
//      });
    } catch (err) {
      print(err);
    }
  }

  void logout() async {
    try {
      await _googleSignIn.signOut();
      print("LOGGED OUT");
//      isLoggedIn = false;
    } catch (err) {
      print(err);
    }
  }
}
