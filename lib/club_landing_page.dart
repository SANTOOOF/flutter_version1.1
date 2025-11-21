import 'package:flutter/material.dart';

void main() {
  runApp(const ClubLandingApp());
}

class ClubLandingApp extends StatelessWidget {
  const ClubLandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0F62FE); // vivid blue
    const secondary = Color(0xFF00B894); // mint green
    const accent = Color(0xFFFFB703); // warm yellow
    const dark = Color(0xFF14213D); // deep navy
    const softBg = Color(0xFFF7FAFC); // near-white

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: dark,
      background: softBg,
      onBackground: dark,
      tertiary: accent,
      onTertiary: Colors.black,
    );

    final textTheme = Typography.blackCupertino.copyWith(
      displayLarge: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.5,
      ),
      headlineMedium: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.35,
        color: Colors.black87,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        height: 1.6,
      ),
      labelLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );

    return MaterialApp(
      title: 'Club Landing',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: softBg,
        textTheme: textTheme,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            side: BorderSide(color: dark.withOpacity(0.18)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  bool _isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 700 && MediaQuery.of(context).size.width < 1024;

  @override
  Widget build(BuildContext context) {
    final isDesktop = _isDesktop(context);
    final isTablet = _isTablet(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: isDesktop
          ? null
          : Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('About'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.event_available_outlined),
                      title: Text('Events'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.groups_outlined),
                      title: Text('Members'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.map_outlined),
                      title: const Text('Map'),
                      onTap: () => Navigator.of(context).pushNamed('/map'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Semantics(
                        button: true,
                        label: 'Join the club',
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person_add_alt_1),
                          label: const Text('Join'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isDesktop ? 80 : 64),
        child: NavBar(
          onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          showMenuButton: !isDesktop,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 72 : (isTablet ? 36 : 20),
                  vertical: isDesktop ? 40 : 24,
                ),
                child: HeroSection(isDesktop: isDesktop, isTablet: isTablet),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 72 : (isTablet ? 36 : 20),
                  vertical: isDesktop ? 24 : 16,
                ),
                child: FeaturesGrid(isDesktop: isDesktop, isTablet: isTablet),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool showMenuButton;
  const NavBar({super.key, required this.onMenuTap, required this.showMenuButton});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      color: cs.background,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.emoji_events, color: cs.primary, size: 28),
              ),
              const SizedBox(width: 12),
              Text('Campus Club', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              if (!showMenuButton) ...[
                NavItem(label: 'About', onTap: () {}),
                NavItem(label: 'Events', onTap: () {}),
                NavItem(label: 'Members', onTap: () {}),
                NavItem(label: 'Map', onTap: () => Navigator.of(context).pushNamed('/map')),
                const SizedBox(width: 12),
                Semantics(
                  button: true,
                  label: 'Join the club',
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Join'),
                  ),
                ),
              ],
              if (showMenuButton)
                IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu),
                  tooltip: 'Open menu',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const NavItem({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(label, style: TextStyle(color: cs.onBackground.withOpacity(0.85))),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  const HeroSection({super.key, required this.isDesktop, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final heroText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect. Create. Grow.',
          style: text.displayLarge?.copyWith(color: cs.onBackground),
          semanticsLabel: 'Main headline: Connect. Create. Grow.',
        ),
        const SizedBox(height: 14),
        Text(
          'We are a student-led club fostering collaboration,\nprojects, and events across campus.',
          style: text.headlineMedium?.copyWith(color: cs.onBackground.withOpacity(0.85)),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Semantics(
              button: true,
              label: 'Join the club',
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1, size: 24),
                label: const Text('Join'),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.play_circle_fill, color: cs.primary),
              label: const Text('Learn more'),
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.onBackground,
              ),
            ),
          ],
        ),
      ],
    );

    final heroCard = Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.groups_3, color: cs.primary, size: 48),
            ),
            const SizedBox(height: 12),
            const Text('1,200+ Members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('40+ Events per year', style: TextStyle(color: Colors.black.withOpacity(0.6))),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.75,
              color: cs.secondary,
              backgroundColor: cs.secondary.withOpacity(0.15),
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: heroText),
              const SizedBox(width: 32),
              Expanded(child: heroCard),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        heroText,
        const SizedBox(height: 20),
        heroCard,
      ],
    );
  }
}

class FeaturesGrid extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  const FeaturesGrid({super.key, required this.isDesktop, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _FeatureData(
        icon: Icons.lightbulb_circle_outlined,
        title: 'Workshops',
        desc: 'Hands-on sessions to learn by building real projects.',
      ),
      _FeatureData(
        icon: Icons.event_available_outlined,
        title: 'Events',
        desc: 'Talks, hackathons, and community gatherings.',
      ),
      _FeatureData(
        icon: Icons.handshake_outlined,
        title: 'Networking',
        desc: 'Meet peers, mentors, and industry professionals.',
      ),
    ];

    final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.2,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) => FeatureCard(data: items[i]),
        ),
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String desc;
  const _FeatureData({required this.icon, required this.title, required this.desc});
}

class FeatureCard extends StatefulWidget {
  final _FeatureData data;
  const FeatureCard({super.key, required this.data});

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowFocusHighlight: (_) => setState(() {}),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          child: Card(
            elevation: _hovered ? 4 : 1.5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: cs.tertiary.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(widget.data.icon, color: cs.tertiary, size: 32),
                  ),
                  const SizedBox(height: 14),
                  Text(widget.data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(widget.data.desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black.withOpacity(0.7))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      color: cs.surface,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Twitter',
                        onPressed: () {},
                        icon: const Icon(Icons.alternate_email),
                      ),
                      IconButton(
                        tooltip: 'YouTube',
                        onPressed: () {},
                        icon: const Icon(Icons.ondemand_video_outlined),
                      ),
                      IconButton(
                        tooltip: 'GitHub',
                        onPressed: () {},
                        icon: const Icon(Icons.code),
                      ),
                      const SizedBox(width: 12),
                      Text('contact@club.org', style: text.bodyLarge),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Row(
                      children: [
                        Expanded(
                          child: Semantics(
                            label: 'Email for newsletter',
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Your email',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: cs.secondary),
                          child: const Text('Subscribe'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200, height: 24),
              const SizedBox(height: 4),
              Text('© ${DateTime.now().year} Campus Club. All rights reserved.',
                  style: TextStyle(color: Colors.black.withOpacity(0.6))),
            ],
          ),
        ),
      ),
    );
  }
}
