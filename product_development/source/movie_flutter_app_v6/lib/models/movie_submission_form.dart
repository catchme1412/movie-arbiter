/// FeedbackForm is a data class which stores data fields of Feedback.
class MovieSubmissionForm {
  String _url;
  String _title;
  String _mobileNo;
  String _feedback;

  MovieSubmissionForm(this._url, this._title, this._mobileNo, this._feedback);

  // Method to make GET parameters.
  String toParams() =>
      "?url=$_url&title=$_title&mobileNo=$_mobileNo&feedback=$_feedback";
}
