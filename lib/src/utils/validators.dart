var regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class Validators {
  static String? validateEmail(String? email) {
    if(email!.isEmpty) {
      return "Enter your email address";
    } else if (!regex.hasMatch(email)) {
      return 'invalid email address';
    } else {
      return null;
    }
  }

  static String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else if(int.parse(value) < 200) {
      return "Amount cannot be less than 200";
    } else {
      return null;
    }
  }

  static String? validateAccount(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else if(value.length < 10) {
      return "Invalid Account Number";
    } else {
      return null;
    }
  }

  static String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else if(value.split(" ").length < 2) {
      return 'Enter a first and last name';
    } else {
      return null;
    }
  }

  static String? validateNin(String? value) {
    if (value!.length != 11) {
      return 'Invalid NIN number';
    } else {
      return null;
    }
  }

  static String? validateDriverLicense(String? value) {
    if (RegExp(r'^[A-Za-z]{3}\d{5}[A-Za-z]{2}\d{2}$').hasMatch(value!)) {
      return null;
    } else {
      return "Invalid License Number";
    }
  }

  static String? validatePlateNumber(String? value) {
    if (RegExp(r'^[A-Za-z]{3}\d{3}[A-Za-z]{2}$').hasMatch(value!)) {
      return null;
    } else {
      return "Invalid Plate Number";
    }
  }

  static String? validatePassword(String? password) {
    if(password!.isEmpty) {
      return "Enter your password";
    } else if (password.length < 8) {
      return 'Password must have at least 8 characters';
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value) {
    if (value!.length != 10) {
      return 'invalid number length';
    } else if (value.startsWith('0', 0)) {
      return 'number can\'t begin with \'0\'';
    } else {
      return null;
    }
  }

}