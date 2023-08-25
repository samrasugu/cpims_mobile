import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';


class UnsyncedWorkflowsPage extends StatefulWidget {
  const UnsyncedWorkflowsPage({Key? key}) : super(key: key);

  @override
  State<UnsyncedWorkflowsPage> createState() => _UnsyncedWorkflowsPageState();
}

class _UnsyncedWorkflowsPageState extends State<UnsyncedWorkflowsPage> {
  final fixedLengthList =
      List<int>.generate(3, (int index) => index * index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Padding(
            padding: kSystemPadding,
            child: CustomCard(title: "Unsynchronized Data", children: [
              Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                children: [
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Workflow",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  ...fixedLengthList
                      .map((e) => const TableRow(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Name",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Workflow",
                              ),
                            ),
                          ]))
                      .toList(),
                ],
              )
            ]),
          ),
        ),
        Positioned(
            bottom: 30,
            right: 30,
            left: 20,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                width: 140,
                child: CustomButton(
                  onTap: () {},
                  text: "Sync Workflows",
                  color: Colors.green,
                ),
              ),
            ]))
      ]),
    );
  }
}
