import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:daily_vegan_app/src/res/custom_form_field.dart';
import 'package:daily_vegan_app/src/utils/validator.dart';
import 'package:intl/intl.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode recipeFocusNode;

  const AddItemForm({
    required this.nameFocusNode,
    required this.recipeFocusNode,
  });

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  bool isChecked = false;

  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();

  var createDate = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addItemFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Row(children: <Widget>[
                      SizedBox(width: 150.0),
                      Text('채식인가요?',
                          style: TextStyle(
                              fontFamily: 'NotoSerifKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      )
                    ]),
                    CustomFormField(
                        isLabelEnabled: false,
                        controller: _nameController,
                        focusNode: widget.nameFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: '제목',
                        hint: '제목 또는 음식 이름',
                        validator: (value) =>
                            Validator.validateField(value: value)),
                    CustomFormField(
                        maxLines: 10,
                        isLabelEnabled: false,
                        controller: _recipeController,
                        focusNode: widget.recipeFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        label: 'recipe',
                        hint: '짧은 기록, 레시피를 적어도 좋아요.',
                        validator: (value) =>
                            Validator.validateField(value: value))
                  ],
                )),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ))
                : Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () async {
                        widget.nameFocusNode.unfocus();
                        widget.recipeFocusNode.unfocus();

                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          await Database.addItem(
                            name: _nameController.text,
                            recipe: _recipeController.text,
                            date: createDate,
                          );

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text('완료',
                            style: TextStyle(
                                fontFamily: 'NotoSerifKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.black)),
                      ),
                    ))
          ],
        ));
  }
}
