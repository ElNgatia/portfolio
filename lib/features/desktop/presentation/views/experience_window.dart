import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/experience_data.dart';
import 'package:portfolio/features/desktop/domain/entity/experience.dart';
import 'package:url_launcher/url_launcher.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7Blue = Color(0xFF0078D7);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);
const _kWin7TagBg = Color(0xFFF0F4F8);
const _kWin7TagBorder = Color(0xFF9BB8D0);
const _kWin7TimelineLine = Color(0xFFBDD4EA);

class ExperienceWindow extends StatelessWidget {
  const ExperienceWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          // Win7-style section header
          Container(
            width: double.infinity,
            color: _kWin7DarkHeader,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Text(
              'Work Experience',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: 1, color: _kWin7CardBorder),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: workExperience.length,
              itemBuilder: (context, index) => _Win7ExperienceCard(
                experience: workExperience[index],
                isFirst: index == 0,
                isLast: index == workExperience.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Win7ExperienceCard extends StatelessWidget {
  const _Win7ExperienceCard({
    required this.experience,
    required this.isFirst,
    required this.isLast,
  });

  final Experience experience;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 32,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 12,
                    color: _kWin7TimelineLine,
                  ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: experience.isCurrent
                        ? _kWin7Blue
                        : const Color(0xFFCCDDEE),
                    border: Border.all(
                      color: experience.isCurrent
                          ? const Color(0xFF005FA3)
                          : _kWin7CardBorder,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: _kWin7TimelineLine,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Card
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _kWin7CardBorder),
                borderRadius: BorderRadius.circular(3),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: const BoxDecoration(
                      color: _kWin7SectionBg,
                      border: Border(
                        bottom: BorderSide(color: _kWin7CardBorder),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            experience.role,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0A246A),
                            ),
                          ),
                        ),
                        if (experience.isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F3FF),
                              border: Border.all(color: _kWin7Blue),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'Current',
                              style: TextStyle(
                                fontSize: 10,
                                color: _kWin7Blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Card body
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company name
                        Text(
                          experience.company,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _kWin7Blue,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Meta row
                        Wrap(
                          spacing: 10,
                          runSpacing: 2,
                          children: [
                            _MetaItem(
                              icon: Icons.calendar_today_outlined,
                              label: experience.duration,
                            ),
                            if (experience.location != null)
                              _MetaItem(
                                icon: Icons.location_on_outlined,
                                label: experience.location!,
                              ),
                            if (experience.employmentType != null)
                              _MetaItem(
                                icon: Icons.work_outline,
                                label: experience.employmentType!,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          experience.description,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),

                        // Highlights
                        if (experience.highlights.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ...experience.highlights.map(
                            (h) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.arrow_right,
                                      size: 14,
                                      color: _kWin7Blue,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      h,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        height: 1.4,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],

                        // Public repositories
                        if (experience.repositories.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          const Text(
                            'Public repositories',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                              color: Color(0xFF0A246A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...experience.repositories.map(
                            (repo) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: _WorkRepoRow(repo: repo),
                            ),
                          ),
                        ],

                        // Skills
                        if (experience.skills.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: experience.skills
                                .map(
                                  (skill) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _kWin7TagBg,
                                      border: Border.all(color: _kWin7TagBorder),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Text(
                                      skill,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF2567A5),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: const Color(0xFF666666)),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF666666)),
        ),
      ],
    );
  }
}

class _WorkRepoRow extends StatelessWidget {
  const _WorkRepoRow({required this.repo});

  final WorkRepository repo;

  Future<void> _open() async {
    final uri = Uri.parse(repo.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _open,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kWin7SectionBg,
            border: Border.all(color: _kWin7CardBorder),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, size: 13, color: _kWin7Blue),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${repo.name} ↗',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: _kWin7Blue,
                      ),
                    ),
                    if (repo.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          repo.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            height: 1.3,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (repo.commits != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _kWin7CardBorder),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '${repo.commits} commits',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2567A5),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
