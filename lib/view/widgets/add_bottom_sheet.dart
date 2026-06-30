import 'dart:typed_data';

import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:book_lab/view/widgets/author_dropdown.dart';
import 'package:book_lab/view/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({
    super.key,
    required this.bottomSheetTitle,
    required this.name,
    required this.description,
    required this.photoText,
    required this.nameHintText,
    required this.descHintText,
    required this.buttonText,
    required this.isBookSeet,
  });

  final String bottomSheetTitle;
  final String name;
  final String description;
  final String photoText;
  final String nameHintText;
  final String descHintText;
  final String buttonText;
  final bool isBookSeet;

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _photo; // to save byte why use Uint8List

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    AuthorProvider authorProvider = Provider.of<AuthorProvider>(
      context,
      listen: false,
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: appThemeTokens.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(top: BorderSide(color: appThemeTokens.border)),
      ),
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.bottomSheetTitle,
                style: TextStyle(
                  fontSize: 20,
                  color: appThemeTokens.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),

          InputFieldWidget(
            title: widget.name,
            hintName: widget.nameHintText,
            controller: _nameController,
            maxLines: 1,
          ),

          SizedBox(height: 16.0),
          InputFieldWidget(
            title: widget.description,
            hintName: widget.descHintText,
            controller: _descriptionController,
            maxLines: 5,
          ),

          if (widget.isBookSeet) AuthorDropdown(),

          SizedBox(height: 16.0),
          Text(
            widget.photoText,
            style: TextStyle(
              color: appThemeTokens.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          TextButton(
            onPressed: () async {
              ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(source: ImageSource.gallery);
              _photo = await file
                  ?.readAsBytes(); // readAsBytes() is async so we need await
              if (_photo != null) {
                setState(() {});
              }
            },
            child: Text("Upload Photo"),
          ),
          SizedBox(height: 4.0),

          if (_photo != null)
            Expanded(
              child: Center(
                child: Image.memory(_photo!, width: 200, height: 200),
              ),
            ),

          if (_photo != null) SizedBox(height: 8.0),

          InkWell(
            onTap: () async {
              String name = _nameController.text.trim();
              String desc = _descriptionController.text.trim();
              if (name.isNotEmpty && desc.isNotEmpty) {
                int result = await authorProvider.saveAuthor(
                  name: name,
                  description: desc,
                  photo: _photo,
                );

                if (result > 0 && context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Save Successfully"),
                    ),
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Data not complete"),
                      content: Text(
                        "Please enter name and description correctly",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appThemeTokens.primary, appThemeTokens.secondary],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  color: appThemeTokens.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
