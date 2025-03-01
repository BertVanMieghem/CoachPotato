import 'package:coach_potato/home/header.dart';
import 'package:coach_potato/home/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[

          // Sidebar Menu
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      shape: BoxShape.circle,

                    ),
                    child: Icon(Icons.person_outline, size: 100, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(color: Theme.of(context).colorScheme.onPrimary),
                MenuItem(title: AppLocalizations.of(context)!.home_trainees),
                MenuItem(title: AppLocalizations.of(context)!.home_trainings),
                MenuItem(title: AppLocalizations.of(context)!.home_templates),
                MenuItem(title: AppLocalizations.of(context)!.home_financial),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Column(
              children: <Widget>[
                Header(),

                // Tiles Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 4 / 3,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              'Tile ${index + 1}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
