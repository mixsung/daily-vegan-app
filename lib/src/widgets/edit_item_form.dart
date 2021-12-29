import 'package:daily_vegan_app/src/res/custom_form_field.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:daily_vegan_app/src/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode recipeFocusNode;
  final String currentName;
  final String currentRecipe;
  final String documentId;

  const EditItemForm({
    required this.nameFocusNode,
    required this.recipeFocusNode,
    required this.currentName,
    required this.currentRecipe,
    required this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _nameController;
  late TextEditingController _recipeController;

  var createDate = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.currentName,
    );

    _recipeController = TextEditingController(
      text: widget.currentRecipe,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
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
                SizedBox(height: 24.0),
                SizedBox(height: 8.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _nameController,
                  focusNode: widget.nameFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Title',
                  hint: 'Enter your note title',
                ),
                SizedBox(height: 24.0),
                SizedBox(height: 8.0),
                CustomFormField(
                  maxLines: 10,
                  isLabelEnabled: false,
                  controller: _recipeController,
                  focusNode: widget.recipeFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Description',
                  hint: 'Enter your note description',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.nameFocusNode.unfocus();
                      widget.recipeFocusNode.unfocus();

                      if (_editItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateItem(
                            docId: widget.documentId,
                            name: _nameController.text,
                            recipe: _recipeController.text,
                            date: createDate);

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        '수정하기',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'NotoSerifKR',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
