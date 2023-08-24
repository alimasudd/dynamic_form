import 'package:flexible_widget/page/page_main.dart';
import 'package:flutter/material.dart';

import 'model.dart';

/// MultiFormWidget
class MultiFormWidget extends StatefulWidget {
  const MultiFormWidget({super.key, this.onDelete, this.student});

  final OnDelete? onDelete;
  final Student? student;

  @override
  State<MultiFormWidget> createState() => _MultiFormWidgetState();

  bool isValid() => _MultiFormWidgetState().validate();
}

class _MultiFormWidgetState extends State<MultiFormWidget> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 180,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.verified_user, color: Colors.white),
          elevation: 0,
          title: const Text('Student Form'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: widget.onDelete,
            )
          ],
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                const SizedBox(height: 5),
                TextFormField(
                  controller: _nameController,
                  onSaved: (val) => widget.student?.name = val,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    alignLabelWithHint: true,
                    hintStyle: Theme
                        .of(context)
                        .inputDecorationTheme
                        .hintStyle,
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be Empty.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ageController,
                  onSaved: (val) => widget.student?.age = val,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    alignLabelWithHint: true,
                    hintStyle: Theme
                        .of(context)
                        .inputDecorationTheme
                        .hintStyle,
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age cannot be Empty.';
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }

  bool validate() {
    final valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}