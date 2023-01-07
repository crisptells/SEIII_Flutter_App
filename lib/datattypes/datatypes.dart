class User {
  final String email;
  final String password;
  final String name;
  final String firstName;
  final int cash;

  const User(
      {required this.email,
      required this.password,
      required this.name,
      required this.firstName,
      required this.cash});

  factory User.fromJson(Map<String, dynamic> json) => User(
      email: json['email'].toString(),
      password: json['password'].toString(),
      name: json['name'].toString(),
      firstName: json['firstName'].toString(),
      cash: int.parse(json['cash'].toString()));
}

class Tutoring {
  final int tutoring_id;
  final String tutor;
  final String subject;
  final String maxStudents;
  //final int? cash;

  const Tutoring({
    required this.tutoring_id,
    required this.tutor,
    required this.subject,
    required this.maxStudents,
    //required this.cash
  });

  static Tutoring fromJson(json) => Tutoring(
        tutoring_id: int.parse(json['tutoring_id']),
        tutor: json['tutor'].toString(),
        subject: json['subject'].toString(),
        maxStudents: json['maxStudents'].toString(),
      );

  /** 
  factory Tutoring.fromJson(Map<String, dynamic> json) {
    return Tutoring(
      tutoring_id: 1,
      tutor: json['Tutor'].toString(),
      subject: json['Subject'].toString(),
      maxStudents: json['MaxStudents'].toString(),
      //cash: json['geld']
    );
  }
  */
}

class UserExp {
  final String user_email;
  final int math;
  final int german;
  final int english;
  final int physics;
  final int chemistry;
  final int informatics;
  //final int? cash;

  const UserExp({
    required this.user_email,
    required this.math,
    required this.german,
    required this.english,
    required this.physics,
    required this.chemistry,
    required this.informatics,
    //required this.cash
  });

  static UserExp fromJson(json) => UserExp(
        user_email: json['user_email'].toString(),
        math: json['math'],
        german: json['german'],
        english: json['english'],
        physics: json['physics'],
        chemistry: json['chemistry'],
        informatics: json['informatics'],
      );

  /** 
  factory Tutoring.fromJson(Map<String, dynamic> json) {
    return Tutoring(
      tutoring_id: 1,
      tutor: json['Tutor'].toString(),
      subject: json['Subject'].toString(),
      maxStudents: json['MaxStudents'].toString(),
      //cash: json['geld']
    );
  }
  */
}
