import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:book_lab/provider/book_provider.dart';
import 'package:book_lab/view/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'author_dropdown.dart';

class UpdateBottomSheet extends StatefulWidget {
  const UpdateBottomSheet({
    super.key,
    required this.currentName,
    required this.currentDescription,
    required this.currentId,
    required this.isBookEdit,
    this.currentAuthorId,
    required this.recordTitle,
    required this.firstInputText,
    required this.firstHintText,
    required this.buttonText,
  });

  final String currentName;
  final String currentDescription;
  final int currentId;
  final int? currentAuthorId;
  final bool isBookEdit;
  final String recordTitle;
  final String firstInputText;
  final String firstHintText;
  final String buttonText;

  @override
  State<UpdateBottomSheet> createState() => _UpdateSheetState();
}

class _UpdateSheetState extends State<UpdateBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  int? selectedId;
  int? selectedAuthorId;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.currentName;
    _descController.text = widget.currentDescription;
    selectedAuthorId = widget.currentAuthorId;
    print("Selected AuthorId: $selectedAuthorId");
  }

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    AuthorProvider authorProvider = Provider.of<AuthorProvider>(
      context,
      listen: false,
    );
    BookProvider bookProvider = Provider.of<BookProvider>(
      context,
      listen: false,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                widget.recordTitle,
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
          SizedBox(height: 16.0),

          InputFieldWidget(
            title: widget.firstInputText,
            hintName: widget.firstHintText,
            controller: _nameController,
            maxLines: 1,
          ),

          SizedBox(height: 16.0),
          InputFieldWidget(
            title: "Description",
            hintName: 'Enter Description',
            controller: _descController,
            maxLines: 5,
          ),

          if (widget.isBookEdit)
            AuthorDropdown(
              onAuthorSelected: (id) {
                selectedId = id;
              },
              initialId: selectedAuthorId,
            ),
          SizedBox(height: 16.0),

          InkWell(
            onTap: () => widget.isBookEdit
                ? updateBook(
                    currentId: widget.currentId,

                    context: context,
                    currentAuthorId: selectedAuthorId!,
                    titleController: _nameController,
                    descController: _descController,
                    bookProvider: bookProvider,
                  )
                : updateAuthor(
                    currentId: widget.currentId,
                    nameController: _nameController,
                    descController: _descController,
                    authorProvider: authorProvider,
                    context: context,
                  ),
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

void updateBook({
  required int currentId,
  required int currentAuthorId,
  required TextEditingController titleController,
  required TextEditingController descController,
  required BookProvider bookProvider,
  required BuildContext context,
}) async {
  int id = currentId;
  String title = titleController.text;
  String desc = descController.text;

  if (title.isNotEmpty & desc.isNotEmpty) {
    int result = await bookProvider.updateBook(
      id: id,
      title: title,
      description: desc,
      authorId: currentAuthorId,
    );
    if (result > 0 && context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Update Successfully"),
        ),
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Data not complete"),
          content: Text("Please enter name and description correctly"),
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
}

void updateAuthor({
  required int currentId,
  required TextEditingController nameController,
  required TextEditingController descController,
  required AuthorProvider authorProvider,
  required BuildContext context,
}) async {
  int id = currentId;
  String name = nameController.text;
  String desc = descController.text;

  if (name.isNotEmpty & desc.isNotEmpty) {
    int result = await authorProvider.updateAuthor(
      id: id,
      name: name,
      description: desc,
    );
    if (result > 0 && context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Update Successfully"),
        ),
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Data not complete"),
          content: Text("Please enter name and description correctly"),
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
}
