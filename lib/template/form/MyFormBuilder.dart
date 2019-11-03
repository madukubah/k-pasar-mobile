import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'MyForm.dart';

class MyFormBuilder {
  List<Widget> forms = [];
  List<Widget> create_forms(List<MyForm> datas,
      {bool readonly = false,
      bool isLabeled = false,
      DecorationType decorationType = DecorationType.ROUNDED}) {
    var form = null;
    var label = null;
    for (var item in datas) {
      label = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.label,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ],
      );
      switch (item.type) {
        case MyForm.TYPE_DATE_PICKTER:
          form = FormBuilderDateTimePicker(
            attribute: item.name,
            // onChanged: _onChanged,
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            initialValue: item.value,
            // decoration: InputDecoration(labelText: "Appointment Time"),
            readOnly: readonly,
          );
          break;
        case MyForm.TYPE_TEXT:
          form = FormBuilderTextField(
            readOnly: readonly,
            initialValue: item.value,
            autofocus: item.autofocus,
            attribute: item.name,
            decoration: (decorationType == DecorationType.PLAIN)
                ? InputDecoration(
                    hintText: item.label,
                  )
                : InputDecoration(
                    hintText: item.label,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
            validators: [
              FormBuilderValidators.required(),
            ],
          );
          break;
        case MyForm.TYPE_EMAIL:
          form = FormBuilderTextField(
            readOnly: readonly,
            initialValue: item.value,
            autofocus: item.autofocus,
            keyboardType: TextInputType.emailAddress,
            attribute: item.name,
            decoration: (decorationType == DecorationType.PLAIN)
                ? InputDecoration(
                    hintText: item.label,
                  )
                : InputDecoration(
                    hintText: item.label,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ],
          );
          break;
        case MyForm.TYPE_NUMBER:
          form = FormBuilderTextField(
            readOnly: readonly,
            initialValue: item.value,
            autofocus: item.autofocus,
            keyboardType: TextInputType.number,
            attribute: item.name,
            decoration: (decorationType == DecorationType.PLAIN)
                ? InputDecoration(
                    hintText: item.label,
                  )
                : InputDecoration(
                    hintText: item.label,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ],
          );
          break;
        case MyForm.TYPE_PASSWORD:
          form = FormBuilderTextField(
            readOnly: readonly,
            initialValue: item.value,
            autofocus: item.autofocus,
            attribute: item.name,
            obscureText: true,
            decoration: (decorationType == DecorationType.PLAIN)
                ? InputDecoration(
                    hintText: item.label,
                  )
                : InputDecoration(
                    hintText: item.label,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
            validators: [
              FormBuilderValidators.required(),
            ],
          );
          break;
        case MyForm.TYPE_SELECT:
          form = FormBuilderDropdown(
            attribute: item.name,
            // readOnly: true,
            initialValue: item.options[0].value,
            validators: [FormBuilderValidators.required()],
            items: item.options,
          );
          break;
      }
      forms.add(SizedBox(height: 8.0));
      if (isLabeled) forms.add(label);
      forms.add(form);
    }
    return forms;
  }
}

enum DecorationType {
  PLAIN,
  ROUNDED,
}
