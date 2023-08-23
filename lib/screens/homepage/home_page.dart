import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/homepage/widgets/homepage_card_primary.dart';
import 'package:cpims_mobile/screens/homepage/widgets/homepage_card_secondary.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    var access = context.read<UIProvider>().getAccess.toString();
    print(">>>>>>>>>>>>>>>>>>> access >>>>>>>>>>>>> $access");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('4THE CHILD - Dashboard',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Application data and usage summary',
            style: TextStyle(color: kTextGrey),
          ),
          const HomepageCardPrimary(
            title : 'UNSYNCED RECORDS',
            icon : FontAwesomeIcons.arrowsRotate,
            color : Color(0xffa10036),
            secondaryColor : Color(0xff630122),
            form1ACount: 4,
            form1BCount: 3,
            cpaCount: 2,
            cparaCount: 1,
          ),
          const HomepageCardPrimary(
            title: 'UNAPPROVED RECORDS',
            icon: FontAwesomeIcons.fileCircleXmark,
            color: Color(0xff947901),
            secondaryColor: Color(0xff524300),
            form1ACount: 4,
            form1BCount: 3,
            cpaCount: 2,
            cparaCount: 1,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomepageCardSecondary(
                data: {
                  'title': 'Org Unit Id',
                  'value': context
                      .read<UIProvider>()
                      .getDashData['org_unit_id']
                      .toString(),
                  'icon': FontAwesomeIcons.orcid,
                  'color': Colors.black54,
                  's_color': Colors.black87,
                },
                // homeCardsTitles[1],
                // context.read<UIProvider>().homeCardsTitles[1]
              ),

              HomepageCardSecondary(
                data: {
                  'title': 'OVC-ACTIVE/EVER REGISTERED',
                  'value': context
                      .read<UIProvider>()
                      .getDashData['caregivers']
                      .toString() ??
                      "null",
                  'icon': FontAwesomeIcons.person,
                  'color': kPrimaryColor,
                  's_color': const Color(0xff0E6668),
                },
                // homeCardsTitles[1],
                // context.read<UIProvider>().homeCardsTitles[1]
              ),

              HomepageCardSecondary(
                data: {
                  'title': 'CAREGIVERS/GUARDIANS',
                  'value': context
                      .read<UIProvider>()
                      .getDashData['caregivers']
                      .toString() ??
                      "null",
                  'icon': FontAwesomeIcons.peopleGroup,
                  'color': const Color(0xff348FE2),
                  's_color': const Color(0xff1F5788),
                },
              ),

              HomepageCardSecondary(
                data: {
                  'title': 'WORKFORCE MEMBERS',
                  'value': context
                      .read<UIProvider>()
                      .getDashData['workforce_members']
                      .toString() ??
                      "null",
                  'icon': Icons.people,
                  'color': const Color(0xff727DB6),
                  's_color': const Color(0xff454A6D),
                },
              ),
              HomepageCardSecondary(
                data: {
                  'title': 'ORG UNITS/CBOs',
                  'value': context
                      .read<UIProvider>()
                      .getDashData['org_units']
                      .toString() ??
                      "null",
                  'icon': FontAwesomeIcons.landmark,
                  'color': const Color(0xff49B6D5),
                  's_color': const Color(0xff2C6E80),
                },
              ),
              HomepageCardSecondary(data: {
                'title': 'HOUSEHOLDS',
                'value':
                context.read<UIProvider>().getDashData['hh_holds'].toString() ??
                    "null",
                'icon': FontAwesomeIcons.house,
                'color': const Color(0xffFE5C57),
                's_color': const Color(0xff9A3734),
              }),
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
