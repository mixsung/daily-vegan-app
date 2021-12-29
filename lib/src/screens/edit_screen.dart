import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:daily_vegan_app/src/widgets/edit_item_form.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String currentName;
  final String currentRecipe;
  final String documentId;

  EditScreen({
    required this.currentName,
    required this.currentRecipe,
    required this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _recipeFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _recipeFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : TextButton(
                    child: Text('삭제',
                        style: TextStyle(
                            fontFamily: 'NotoSerifKR',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            color: Colors.black)),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
              documentId: widget.documentId,
              nameFocusNode: _nameFocusNode,
              recipeFocusNode: _recipeFocusNode,
              currentName: widget.currentName,
              currentRecipe: widget.currentRecipe,
            ),
          ),
        ),
      ),
    );
  }
}
