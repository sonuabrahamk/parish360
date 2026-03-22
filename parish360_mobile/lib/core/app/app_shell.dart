import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/app/widgets/modules_navbar.dart';
import 'package:parish360_mobile/core/app/widgets/parish_drawer.dart';
import 'package:parish360_mobile/features/auth/data/providers/auth_providers.dart';
import 'package:parish360_mobile/features/auth/data/providers/module_index_providers.dart';

class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleInfoList = ref.watch(modulesProvider);
    final selectedIndex = ref.watch(moduleIndexProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          moduleInfoList[selectedIndex].label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: ParishDrawer(parishes: []),
      
      body: child,

      bottomNavigationBar: moduleInfoList.isEmpty ? null : ModulesNavBar(),
    );
  }
}
