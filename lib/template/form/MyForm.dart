import 'package:flutter/material.dart';

class MyForm {
  static const String TYPE_TEXT = "text";
  static const String TYPE_PASSWORD = "password";
  static const String TYPE_EMAIL = "email";
  static const String TYPE_NUMBER = "number";
  static const String TYPE_SELECT = "select";
  static const String TYPE_DATE_PICKTER = "date-picker";
  final String type;
  final String label;
  final String name;
  final bool autofocus;
  final List< DropdownMenuItem > options ;
  final value;

  MyForm( {  this.autofocus = false, this.type = "", this.label="", this.name="", this.value = "", this.options  } );

}

