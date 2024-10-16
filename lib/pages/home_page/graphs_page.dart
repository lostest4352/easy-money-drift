import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_classes.dart';
import 'package:flutter_expense_tracker/models/pie_chart_model.dart';
import 'package:flutter_expense_tracker/pages/page_functions/calculate_total.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({super.key});

  @override
  State<GraphsPage> createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Income'),
    Tab(text: 'Expenses'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphs Page"),
        toolbarHeight: 45,
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsLoadedState) {
            final calculatedValue =
                calculateTotalIncomeOrExpenses(state.listOfTransactionData!);

            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: myTabs,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TransactionWidget(
                        isIncome: true,
                        totalValue: calculatedValue.totalIncome,
                        transactionList: state.listOfTransactionData,
                      ),
                      TransactionWidget(
                        isIncome: false,
                        totalValue: calculatedValue.totalExpense,
                        transactionList: state.listOfTransactionData,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final bool isIncome;
  final int totalValue;
  final List<TransactionModelIsar>? transactionList;
  const TransactionWidget({
    Key? key,
    required this.isIncome,
    required this.totalValue,
    required this.transactionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final seen = <CategoryModel>{};
    // List<CategoryModel> filteredTransaction = listItems.where(
    //   (transactionModel) {
    //     var val = seen.add(transactionModel.transactionType);
    //     return val;
    //   },
    // ).toList();

    List<PieChartModel> pieChartModelList = [];

    if (transactionList != null) {
      for (final transaction in transactionList!) {
        bool found = false;
        for (final pieChartModel in pieChartModelList) {
          if (pieChartModel.transactionType == transaction.transactionType &&
              pieChartModel.isIncome == transaction.isIncome &&
              pieChartModel.colorsValue == transaction.colorsValue) {
            found = true;
            pieChartModel.amount += transaction.amount;
          }
        }

        if (!found) {
          pieChartModelList.add(
            PieChartModel(
              transactionType: transaction.transactionType,
              isIncome: transaction.isIncome,
              colorsValue: transaction.colorsValue,
              amount: transaction.amount,
            ),
          );
        }
      }
    }

    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              // sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: [
                for (final pieChartTransaction in pieChartModelList)
                  if (pieChartTransaction.isIncome == isIncome)
                    PieChartSectionData(
                      // title:
                      //     "${pieChartTransaction.transactionType}%",
                      showTitle: false,
                      badgeWidget: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black45,
                        ),
                        padding: const EdgeInsets.all(2),
                        
                        child: Text("${((pieChartTransaction.amount / totalValue) * 100).toStringAsFixed(1)}%"),
                      ),
                      titlePositionPercentageOffset: 1.8,
                      value: pieChartTransaction.amount.toDouble(),
                      color: Color(pieChartTransaction.colorsValue),
                    ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            for (final pieChartTransaction in pieChartModelList)
              if (pieChartTransaction.isIncome == isIncome)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(pieChartTransaction.transactionType),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          color: Color(pieChartTransaction.colorsValue),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            const Divider(),
            ListTile(
              title: const Text("Total"),
              trailing: Text("$totalValue"),
            ),
            const Divider(),
            for (final pieChartTransaction in pieChartModelList)
              if (pieChartTransaction.isIncome == isIncome)
                ListTile(
                  title: Text(pieChartTransaction.transactionType),
                  trailing: Text(
                    pieChartTransaction.amount.toString(),
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
