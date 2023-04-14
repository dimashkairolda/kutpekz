import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/pages/bottom_nav/history/history_active.dart';
import 'package:kutpekz/pages/bottom_nav/history/history_inactive.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context,listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.btm_nav_history.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                child: Text(
                  'Активно',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                  color: Theme.of(context).primaryColor),
                ),
              ),
              Tab(
                child: Text(
                  'Завершено',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ]),
            const Expanded(
              child: TabBarView(
                children: [
                  Active(),
                  Inactive(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
