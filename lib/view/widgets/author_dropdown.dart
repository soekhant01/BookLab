import 'package:book_lab/data/model/author_model.dart';
import 'package:book_lab/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDropdown extends StatefulWidget {
  const AuthorDropdown({
    super.key,
    required this.onAuthorSelected,
    this.initialId,
  });

  final Function(int) onAuthorSelected;
  final int? initialId;

  @override
  State<AuthorDropdown> createState() => _AuthorDropdownState();
}

class _AuthorDropdownState extends State<AuthorDropdown> {
  int? selectedId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedId = widget.initialId;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorProvider>(
      builder: (_, AuthorProvider provider, _) {
        List<AuthorModel> authors = provider.authors;
        return Padding(
          padding: EdgeInsetsGeometry.only(top: 16),
          child: DropdownMenu(
            width: 370,
            dropdownMenuEntries: authors.map((author) {
              return DropdownMenuEntry<int>(
                value: author.id,
                label: author.name,
              );
            }).toList(),
            label: const Text("Select Author"),
            initialSelection: widget.initialId,
            onSelected: (int? value) {
              setState(() {
                widget.onAuthorSelected(value!);
              });
            },
          ),
        );
      },
    );
  }
}
