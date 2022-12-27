class User {
  final String? email;
  final String? password;
  final String? name;
  final String? firstName;
  final int? cash;

  const User(
      {required this.email,
      required this.password,
      required this.name,
      required this.firstName,
      required this.cash});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        firstName: json['firstName'],
        cash: json['geld']);
  }
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
