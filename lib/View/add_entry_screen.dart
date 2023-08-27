import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_form_field.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _total = TextEditingController();
  TextEditingController _cost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CommonFormField(controller: _title, hint: "Enter Title"),
            Consumer<TransactionListProvider>(builder: (context, value, child) {
              return DropdownButton(
                  isExpanded: true,
                  elevation: 0,
                  value: value.getSelectedIncome,
                  alignment: AlignmentDirectional.bottomCenter,

                  // disabledHint: Text("Set Income Category"),
                  items: List.generate(value.getIncomeCategory.length, (index) {
                    return DropdownMenuItem(
                        child: Text(value.getIncomeCategory[index]),
                        value: index);
                  }),
                  onChanged: (val) {
                    value.setIncome(val!);
                  });
            })
          ],
        ),
      ),
    ));
  }
}
