import 'package:flutter/material.dart';

class ActionItem {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? labelColor;

  ActionItem(
      {required this.icon,
      required this.label,
      this.iconColor,
      this.labelColor});
}

class ActionButtonStack extends StatelessWidget {
  final List<ActionItem> actions;
  final Function(int) onTap;
  final bool includeDivider;

  ActionButtonStack(
      {required this.actions, required this.onTap, this.includeDivider = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: Column(
          children: [
            ListView.builder(
                itemCount: actions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final action = actions[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          onTap(index);
                        },
                        splashColor: Theme.of(context).colorScheme.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: action.iconColor ??
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(action.icon),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  action.label,
                                  style: TextStyle(
                                      color: action.labelColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: action.iconColor,
                            )
                          ],
                        ),
                      ),
                      if (index != actions.length - 1 && includeDivider)
                        const SizedBox(height: 12),
                      if (index != actions.length - 1 && includeDivider)
                        const Divider(height: 12),
                      if (index != actions.length - 1 && includeDivider)
                        const SizedBox(height: 12),
                      if (index != actions.length - 1 &&
                          includeDivider == false)
                        const SizedBox(height: 16)
                    ],
                  );
                })
          ],
        ));
  }
}
