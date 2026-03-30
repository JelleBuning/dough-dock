import 'package:dough_dock/routing/routes.dart';
import 'package:dough_dock/ui/dough/enums/dough_type.dart';
import 'package:go_router/go_router.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:dough_dock/ui/dough/widgets/doses.dart';
import 'package:dough_dock/ui/dough/widgets/dough_configurator.dart';
import 'package:dough_dock/ui/dough/widgets/dough_type_dropdown.dart';
import 'package:dough_dock/ui/dough/widgets/preferment_radio_cards.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoughPage extends StatefulWidget {
  const DoughPage({super.key});

  @override
  State<DoughPage> createState() => _DoughPageState();
}

class _DoughPageState extends State<DoughPage> {
  var _selectedDoughType = DoughType.neapolitan;

  final _datetimeInputController = TextEditingController();
  final FocusNode _datetimeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _datetimeFocusNode.addListener(() {
      if (_datetimeFocusNode.hasFocus) {
        _showDateTimePicker(context);
        _datetimeFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _datetimeInputController.dispose();
    _datetimeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: DoughTypeDropdown(
          onDoughTypeChanged: (doughType) {
            setState(() => _selectedDoughType = doughType);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final session = await context.read<DoughViewModel>().saveSession();
          if (context.mounted) {
            context.go(Routes.home.sessionDetail(session.id));
          }
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _readyAtField(),
              const DoughConfigurator(),
              if (_selectedDoughType == DoughType.neapolitanPreferment)
                PrefermentationType(
                  onPrefermentChanged: (value) {
                    var _ = value;
                  },
                ),
              const Doses(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _readyAtField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Ready at',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      controller: _datetimeInputController,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Due required';
        return null;
      },
      readOnly: true,
      focusNode: _datetimeFocusNode,
    );
  }

  void _showDateTimePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) => child!,
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((date) {
      if (date != null && context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showTimePicker(
            context: context,
            builder:
                (context, child) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                ),
            initialEntryMode: TimePickerEntryMode.inputOnly,
            initialTime: const TimeOfDay(hour: 18, minute: 0),
          ).then((time) {
            if (time != null && context.mounted) {
              _setDateInput(
                date.copyWith(hour: time.hour, minute: time.minute),
              );
            }
          });
        });
      }
    });
  }

  void _setDateInput(DateTime endDate) {
    context.read<DoughViewModel>().setBakeTime(endDate);
    setState(() {
      _datetimeInputController.text = DateFormat('EEEE HH:mm').format(endDate);
    });
  }
}
