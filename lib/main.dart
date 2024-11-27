import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'bloc/app_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.light(
                surface: Colors.white,
                primary: Colors.blue.shade700,
                secondary: Colors.grey.shade200,
              ),
              dividerColor: const Color(0xFFE5E5E5),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: ColorScheme.dark(
                surface: const Color(0xFF2D2D2D),
                primary: Colors.blue.shade500,
                secondary: Colors.grey.shade800,
              ),
              dividerColor: const Color(0xFF404040),
            ),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // macOS-style title bar
          Container(
            height: 28,
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                const SizedBox(width: 70), // Space for traffic lights
                Expanded(
                  child: Center(
                    child: Text(
                      'Image Tool Kit',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 70), // Balance the layout
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      // Navigation items
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            _NavigationItem(
                              icon: Icons.home_outlined,
                              label: 'Home',
                              selected: true,
                              onTap: () {},
                            ),
                            _NavigationItem(
                              icon: Icons.image_outlined,
                              label: 'Images',
                              onTap: () {},
                            ),
                            _NavigationItem(
                              icon: Icons.folder_outlined,
                              label: 'Projects',
                              onTap: () {},
                            ),
                            const Divider(height: 16),
                            _NavigationItem(
                              icon: Icons.settings_outlined,
                              label: 'Settings',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      // Theme toggle at bottom
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            context.watch<AppBloc>().state.isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            size: 16,
                          ),
                          onPressed: () {
                            context.read<AppBloc>().add(ToggleThemeEvent());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const Center(
                      child: Text('Select an item from the sidebar'),
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

class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected
          ? theme.colorScheme.primary.withOpacity(0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
