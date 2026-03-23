import 'package:dough_dock/ui/dough/enums/dough_type.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:dough_dock/ui/dough/widgets/doses.dart';
import 'package:dough_dock/ui/dough/widgets/dough_configurator.dart';
import 'package:dough_dock/ui/dough/widgets/dough_type_dropdown.dart';
import 'package:dough_dock/ui/dough/widgets/preferment_radio_cards.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DoughPage extends StatefulWidget {
  const DoughPage({super.key, required this.viewModel});

  final DoughViewModel viewModel;

  @override
  State<DoughPage> createState() => _DoughPageState();
}

class _DoughPageState extends State<DoughPage> {
  var selectedDoughType = DoughType.neapolitan;

  final _datetimeInputController = TextEditingController();
  final FocusNode _datetimeFocusNode = FocusNode();

  @override
  void initState() {
    _datetimeFocusNode.addListener(() {
      if (_datetimeFocusNode.hasFocus) {
        showDateTimePicker(context);
        _datetimeFocusNode.unfocus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: DoughTypeDropdown(
          onDoughTypeChanged: (doughType) {
            setState(() {
              selectedDoughType = doughType;
            });
          },
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Under construction')),
                ),
              );
            },
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder:
            (context, child) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    readyAtField(),
                    DoughConfigurator(viewModel: widget.viewModel),
                    selectedDoughType == DoughType.neapolitanPreferment
                        ? PrefermentationType(
                          onPrefermentChanged: (value) {
                            var _ = value;
                          },
                        )
                        : const SizedBox.shrink(),
                    Doses(viewModel: widget.viewModel),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  TextFormField readyAtField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Ready at',
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      controller: _datetimeInputController,
      validator: (value) {
        if (value == null || value == "") {
          return 'Due required';
        }
        return null;
      },
      readOnly: true,
      focusNode: _datetimeFocusNode,
    );
  }

  void showDateTimePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return child!;
      },
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((date) {
      if (date != null && context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showTimePicker(
            context: context,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
            initialEntryMode: TimePickerEntryMode.inputOnly,
            initialTime: const TimeOfDay(hour: 18, minute: 0),
          ).then((time) {
            if (time != null && context.mounted) {
              setDateInput(date.copyWith(hour: time.hour, minute: time.minute));
            }
          });
        });
      }
    });
  }

  void setDateInput(DateTime endDate) {
    widget.viewModel.setBakeTime(endDate);
    setState(() {
      _datetimeInputController.text = DateFormat("EEEE HH:mm").format(endDate);
    });
  }
}
