import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:book_lab/view/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

          InkWell(
            onTap: () async {
              String name = _nameController.text.trim();
              String desc = _descriptionController.text.trim();
              if (name.isNotEmpty && desc.isNotEmpty) {
                int result = await authorProvider.saveAuthor(
                  name: name,
                  description: desc,
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
                "Save Author",
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
