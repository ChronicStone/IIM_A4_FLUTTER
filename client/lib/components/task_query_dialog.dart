import 'package:flutter/material.dart';

class FilterTasksModal extends StatefulWidget {
  final String? sortKey;
  final String? sortDir;
  final String? searchQuery;
  final Function(
      {required String? searchQuery,
      required String? sortKey,
      required String? sortDir}) onSearch;

  FilterTasksModal(
      {required this.onSearch,
      required this.searchQuery,
      required this.sortDir,
      required this.sortKey});
  @override
  _FilterTasksModalState createState() => _FilterTasksModalState();
}

class _FilterTasksModalState extends State<FilterTasksModal> {
  late String? _sortKey;
  late String? _sortDir;
  late String? _searchQuery;

  @override
  void initState() {
    debugPrint('QUERYINPUT: ${widget.searchQuery}');
    _searchQuery = widget.searchQuery;
    _sortDir = widget.sortDir;
    _sortKey = widget.sortKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter tasks'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropdown(
                label: 'Sort key',
                value: _sortKey,
                values: ['createdAt', 'updatedAt', 'progress'],
                onChanged: (value) {
                  setState(() {
                    _sortKey = value;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            _buildDropdown(
                label: 'Sort direction',
                value: _sortDir,
                values: ['ASC', 'DESC'],
                onChanged: (value) {
                  setState(() {
                    _sortDir = value;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            _buildTextField(
                label: 'Search query',
                value: _searchQuery,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                }),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Reset'),
          onPressed: () {
            widget.onSearch(searchQuery: null, sortDir: null, sortKey: null);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Search'),
          onPressed: () {
            widget.onSearch(
                searchQuery: _searchQuery,
                sortDir: _sortDir,
                sortKey: _sortKey);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildDropdown(
      {required String label,
      required List<String> values,
      required Function(String?) onChanged,
      required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text(''),
            ),
            ...values.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required String label,
      required String? value,
      required Function(String?) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
