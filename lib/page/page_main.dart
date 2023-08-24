import 'package:flutter/material.dart';

import 'model.dart';
import 'multi_form.dart';

class pageMain extends StatefulWidget {
  const pageMain({super.key});

  @override
  State<pageMain> createState() => _pageMainState();
}

class _pageMainState extends State<pageMain> {
  List<MultiFormWidget> pages = []; // <---- add this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Students',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  color: Colors.white,
                )),
            onPressed: onSaveForm,
            child: Text(
              'Submit',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: Container(
        child: pages.isEmpty
            ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text('Tap on button to add'),
              TextButton.icon(
                  onPressed: onAddForm,
                  icon: const Icon(Icons.add),
                  label: const Text('Add new')),
            ],
          ),
        )
            : ListView.separated(
            padding: const EdgeInsets.all(24),
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            separatorBuilder: (_, index) => const Divider(
              color: Colors.white,
            ),
            itemCount: pages.isEmpty ? 0 : pages.length,
            itemBuilder: (_, index) => pages[index]),
      ),
      floatingActionButton: Visibility(
        visible: pages.isNotEmpty,
        child: FloatingActionButton(
          onPressed: onAddForm,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  ///on form user deleted
  void onDelete(Student student) {
    setState(() {
      final find = pages.firstWhere(
            (it) => it.student == student,
      );
      if (find != null) pages.removeAt(pages.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      final student = Student();
      pages.add(MultiFormWidget(
        student: student,
        onDelete: () => onDelete(student),
      ));
    });
  }

  /// on save form
  void onSaveForm() {
    if (pages.isNotEmpty) {
      bool allValid = true;
      for (final multiFormWidget in pages) {
        // loop and check if all input fields a validated
        allValid = allValid && multiFormWidget.isValid();
      }
      if (allValid) {
        // all input fields is valid, get values
        final data = pages.map((it) => it.student).toList();

        /// you can go ahead and furthur manipulate the data or make a network call to your API
        print('data: $data');
        ScaffoldMessenger.of(context)
            .showMaterialBanner(MaterialBanner(content: Text('$data'), actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('ok'))
        ]));
      }
    }
  }
}


typedef OnDelete = Function();