import 'package:flutter/material.dart';
import 'package:stock_frontend/constants/colors.dart';
import 'package:stock_frontend/constants/styles.dart';
import 'package:stock_frontend/widgets/team_member_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        padding: AppStyles.sectionPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SectionCard(
              title: 'Project Overview',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'This Stock Market App was developed as part of the Frontend Development course led by Mr. Erkin Erdogan. It was also developed in parallel with the IT Agile course instructed by Dr. Mohammed Nazeh Alimam. The app simulates a stock market experience with a responsive, interactive frontend. All five team members are in the same class, major, and academic year.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 24),
                  UniversityInfoCard(),
                ],
              ),
            ),
            SizedBox(height: 32),
            SectionCard(
              title: 'Our Philosophy',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.autorenew, color: AppColors.background),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Fluid Team Roles',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Roles were fluid and flexible. Instead of fixed responsibilities, everyone contributed across design, code, testing, and planning depending on the project phase. This collaborative approach helped each of us grow and support the team more effectively.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            SectionHeader('Our Team'),
            SizedBox(height: 16),
            TeamMembersGrid(),
            SizedBox(height: 32),
            SectionCard(
              title: 'Tech Stack',
              content: TechStackGrid(),
            ),
            SizedBox(height: 32),
            SectionCard(
              title: 'Reflection & Acknowledgment',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'This project helped us apply theory in a real-world scenario using agile methods. We thank Mr. Erkin Erdogan for his frontend development guidance and Dr. Mohammed Nazeh Alimam for introducing agile workflows that shaped our process.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 24),
                  AcknowledgmentCard(),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget content;

  const SectionCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.sectionPadding,
      decoration: AppStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.sectionHeader),
          content,
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppStyles.sectionHeader);
  }
}

class UniversityInfoCard extends StatelessWidget {
  const UniversityInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.sectionPadding,
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset('assets/ue_logo.png', height: 80),
          const SizedBox(height: 8),
          const Text('University of Europe', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('for Applied Sciences', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class TeamMembersGrid extends StatelessWidget {
  const TeamMembersGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }
}

class TechStackGrid extends StatelessWidget {
  const TechStackGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }
}

class AcknowledgmentCard extends StatelessWidget {
  const AcknowledgmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.sectionPadding,
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
