/// A typedef for email and password credentials.
typedef EmailAndPasswordCredential = (
  String email,
  String password,
  Map<String, dynamic>? metaData
);

/// A typedef for phone and password credentials.
typedef PhoneAndPasswordCredential = (
  String phone,
  String password,
);
