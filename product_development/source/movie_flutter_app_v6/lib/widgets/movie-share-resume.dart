import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_flutter_app_v6/controller/movie_submission_form_controller.dart';
import 'package:movie_flutter_app_v6/models/movie_submission_form.dart';
import 'package:movie_flutter_app_v6/widgets/page_footer.dart';

class MovieShareResume extends StatefulWidget {
  final Map<dynamic, dynamic> sharedData;

  const MovieShareResume({Key key, this.sharedData}) : super(key: key);
  @override
  _MovieShareResumeState createState() => _MovieShareResumeState(sharedData);
}

class _MovieShareResumeState extends State<MovieShareResume> {
  final Map<dynamic, dynamic> sharedData;
  bool _isButtonDisabled = false;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController titleController = new TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  _MovieShareResumeState(this.sharedData);

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      SnackBar snackBar = buildSnackbar();
      _scaffoldKey.currentState.showSnackBar(snackBar);
      MovieSubmissionForm feedbackForm = MovieSubmissionForm(urlController.text,
          titleController.text, urlController.text, urlController.text);

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          print(("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"));
        } else {
          // Error Occurred while saving data in Google Sheets.
          print(("FFFFFFFFFFFFFFFFFFFFFFFFFFFFF"));
        }
      });

//      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    urlController.text = sharedData.values.elementAt(1).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Movie Arbiter"),
      ),
      bottomNavigationBar: PageFooterBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                  child: Image.asset("assets/images/share-4.png"),
                ),
                Text(
                  "Youtube title:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Text(
                    sharedData.values.elementAt(0).toString(),
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: titleController,
                    obscureText: false,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correct name of this movie?',
                    ),
                    validator: (value) {
                      if (value.trim().length == 0) {
                        return 'Please provide the movie name';
                      }
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (_isButtonDisabled) {
                      return null;
                    } else {
                      _submitMovie();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _isButtonDisabled
                          ? Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.add_to_home_screen,
                              color: Colors.white,
                            ),
                      Text(
                        _isButtonDisabled ? " Done" : "Submit for review",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitMovie() {
    _submitForm();
    setState(() {
      _isButtonDisabled = true;
    });
  }

  SnackBar buildSnackbar() {
    SnackBar snackbar = SnackBar(
      backgroundColor: Colors.orange,
      duration: Duration(seconds: 7),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/success.gif",
            height: 100,
          ),
          SizedBox(
            height: 30,
          ),
          Flexible(
            child: Text(
              "Congratulations! You have shared your movie.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: Text(
              "Your contribution will appear after admin's approval",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          //
        ],
      ),
    );
    return snackbar;
  }
}
