import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';

import '../viewmodels/locale_viewmodel.dart';
import '../widgets/footer.dart';
import '../widgets/small_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _getLanguageName(BuildContext context, String? languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'pt':
        return 'Português';
      default:
        return 'Português';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeViewModel = context.watch<LocaleViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.configuracoesMainTitle),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              l10n.configuracoesMainTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Divider(indent: 80, endIndent: 80),
            const SizedBox(height: 40),

            DropdownButton<String>(
              value: localeViewModel.appLocale?.languageCode,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
              underline: Container(
                height: 2,
                color: Theme.of(context).primaryColorDark,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  localeViewModel.changeLocale(newValue);
                }
              },
              items: <String>['pt', 'en'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(_getLanguageName(context, value)),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            SmallButton(
              text: l10n.sobre, // Adicionar ao l10n
              icon: Icons.info_outline,
              onClick: () {
                // Navegação para a tela "Sobre" (a ser criada)
              },
            ),
            const SizedBox(height: 16),
            SmallButton(
              text: l10n.contato, // Adicionar ao l10n
              icon: Icons.phone_outlined,
              onClick: () {
                // Navegação para a tela "Contato" (a ser criada)
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'settings'),
    );
  }
}