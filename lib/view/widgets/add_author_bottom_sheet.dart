import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/view/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';

class AddAuthorBottomSheet extends StatefulWidget {
  const AddAuthorBottomSheet({super.key});

  @override
  State<AddAuthorBottomSheet> createState() => _AddAuthorBottomSheetState();
}

class _AddAuthorBottomSheetState extends State<AddAuthorBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
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
                "Insert Box Record",
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
            title: 'Author Name',
            hintName: 'Enter Author Name',
            controller: _nameController,
            maxLines: 1,
          ),

          SizedBox(height: 16.0),
          InputFieldWidget(
            title: 'Description',
            hintName: 'Enter Description',
            controller: _descriptionController,
            maxLines: 5,
          ),
          SizedBox(height: 16.0),
          Text(
            "Author Photo (optional)",
            style: TextStyle(
              color: appThemeTokens.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          TextButton(onPressed: () {}, child: Text("Upload Photo")),
        ],
      ),
    );
  }
}
