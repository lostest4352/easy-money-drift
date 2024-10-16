import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/search_cubit/search_cubit.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/pages/page_functions/date_formatter.dart';
import 'package:flutter_expense_tracker/pages/home_page/transaction_view.dart';
import 'package:flutter_expense_tracker/pages/widgets/popup_textfield_items.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: PopupTextFieldItems(
                    textEditingController: textEditingController,
                    hintText: "Search",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (textEditingController.text.trim().isNotEmpty) {
                          context
                              .read<SearchCubit>()
                              .searchClicked(textEditingController.text);
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state is SearchLoadedState) {
                final List<TransactionModelIsar>? transactionsList =
                    state.listOfTransactionData;
                transactionsList?.sort(
                  (a, b) => b.dateTime.compareTo(a.dateTime),
                );
                return Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactionsList?.length,
                        itemBuilder: (context, index) {
                          if (transactionsList == null) {
                            return const Center(
                              child: Text("No Data"),
                            );
                          }
                          final String transactionDate =
                              DateTime.parse(transactionsList[index].dateTime)
                                  .formatDay();
                          return Column(
                            children: [
                              () {
                                if (transactionDate ==
                                    DateTime.now().formatDay().toString()) {
                                  return const Text(
                                    'Today',
                                  );
                                } else {
                                  return Text(
                                    transactionDate,
                                  );
                                }
                              }(),
                              TransactionView(
                                transaction: transactionsList[index],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("Not searched yet"),
                );
              }
            },
          ),
        );
      },
    );
  }
}
