import 'package:dough_dock/ui/dough/enumerables/dough_type.dart';
import 'package:flutter/material.dart';

class DoughTypeDropdown extends StatefulWidget {
  final ValueChanged<DoughType> onDoughTypeChanged;

  const DoughTypeDropdown({super.key, required this.onDoughTypeChanged});

  @override
  State<DoughTypeDropdown> createState() => _DoughTypeDropdownState();
}

class _DoughTypeDropdownState extends State<DoughTypeDropdown> {
  DoughType selected = DoughType.neapolitan;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton<DoughType>(
        tooltip: '',
        offset: Offset(-1, 35),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selected.displayValue(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
        itemBuilder: (context) {
          return DoughType.values.map((DoughType doughType) {
            return PopupMenuItem<DoughType>(
              enabled: doughType.active,
              value: doughType,
              child: Text(doughType.displayValue()),
              onTap: () {
                selected = doughType;
                widget.onDoughTypeChanged(doughType);
              },
            );
          }).toList();
        },
      ),
    );
  }
}
