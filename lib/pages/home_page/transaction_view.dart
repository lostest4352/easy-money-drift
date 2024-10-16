import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/pages/home_page/entry_dialog.dart';

class TransactionView extends StatelessWidget {
  final TransactionModelIsar transaction;
  const TransactionView({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EntryDialog(
                    editMode: true,
                    transaction: transaction,
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(120, 33, 149, 243),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: (transaction.isIncome == true)
                            ? Colors.green
                            : Colors.red,
                        maxRadius: 12,
                        child: (transaction.isIncome == true)
                            ? const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.transactionType,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Text(
                          "${transaction.amount}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: (transaction.isIncome == true)
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: () {
                        if (transaction.note != null) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              children: [
                                Text(
                                  "${transaction.note}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
