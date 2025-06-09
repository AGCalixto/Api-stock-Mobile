import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/widgets/team_member_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Project Overview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppStyles.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Project Overview', style: AppStyles.sectionHeader),
                  const SizedBox(height: 16),
                  const Text(
                    'This Stock Market App was developed as part of the Frontend Development course led by Mr. Erkin Erdogan. It was also developed in parallel with the IT Agile course instructed by Dr. Mohammed Nazeh Alimam. The app simulates a stock market experience with a responsive, interactive frontend. All five team members are in the same class, major, and academic year.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/ue_logo.png', // Add actual asset
                                height: 80,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'University of Europe',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'for Applied Sciences',
                                style: TextStyle(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Team Philosophy
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppStyles.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Our Philosophy', style: AppStyles.sectionHeader),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(Icons.autorenew, color: AppColors.background),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Fluid Team Roles',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Roles were fluid and flexible. Instead of fixed responsibilities, everyone contributed across design, code, testing, and planning depending on the project phase. This collaborative approach helped each of us grow and support the team more effectively.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Team Members
            const Text('Our Team', style: AppStyles.sectionHeader),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                TeamMemberCard(
                  initials: 'DA',
                  name: 'Diego Acosta',
                  role: 'UI Design & Layout',
                  email: 'diegoandres.acostacantu@ue-germany.de',
                ),
                TeamMemberCard(
                  initials: 'MG',
                  name: 'Miguel Garcia',
                  role: 'Architecture & Testing',
                  email: 'miguelangel.garciahiguita@ue-germany.de',
                ),
                TeamMemberCard(
                  initials: 'DG',
                  name: 'Dennis Guerra',
                  role: 'Data & UI Consistency',
                  email: 'dennisalejandro.guerracalix@ue-germany.de',
                ),
                TeamMemberCard(
                  initials: 'KQ',
                  name: 'Keven Quevedo',
                  role: 'Validation & Interactivity',
                  email: 'kevenjaffet.quevedocontreras@ue-germany.de',
                ),
                TeamMemberCard(
                  initials: 'SB',
                  name: 'Sinjini Banerjee',
                  role: 'Visual Design & UX',
                  email: 'sinjini.banerjee@ue-germany.de',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Tech Stack
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppStyles.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tech Stack', style: AppStyles.sectionHeader),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: const [
                      TechIcon(icon: Icons.code, label: 'HTML5'),
                      TechIcon(icon: Icons.style, label: 'CSS3'),
                      TechIcon(icon: Icons.javascript, label: 'JavaScript'),
                      TechIcon(icon: Icons.language, label: 'Bootstrap'),
                      TechIcon(icon: Icons.bar_chart, label: 'Chart.js'),
                      TechIcon(icon: Icons.cloud, label: 'MarketStack API'),
                      TechIcon(icon: Icons.phone_android, label: 'Flutter'),
                      TechIcon(icon: Icons.design_services, label: 'Figma'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Reflection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppStyles.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reflection & Acknowledgment', style: AppStyles.sectionHeader),
                  const SizedBox(height: 16),
                  const Text(
                    'This project helped us apply theory in a real-world scenario using agile methods. We thank Mr. Erkin Erdogan for his frontend development guidance and Dr. Mohammed Nazeh Alimam for introducing agile workflows that shaped our process.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      children: [
                        Text('Special Thanks To', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text('EE', style: TextStyle(color: AppColors.background)),
                          ),
                          title: Text('Mr. Erkin Erdogan'),
                          subtitle: Text('Frontend Development Instructor'),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.accent,
                            child: Text('MA', style: TextStyle(color: AppColors.background)),
                          ),
                          title: Text('Dr. Mohammed Nazeh Alimam'),
                          subtitle: Text('IT Agile Instructor'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class TechIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const TechIcon({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 32, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}