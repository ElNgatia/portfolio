import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/data/experience_data.dart';
import 'package:portfolio/features/desktop/domain/entity/experience.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';

class ExperienceWindow extends StatelessWidget {
  const ExperienceWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'Work Experience'),
          Container(height: 1, color: skin.divider),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: workExperience.length,
              itemBuilder: (context, index) => _ExperienceCard(
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

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.experience,
    required this.isFirst,
    required this.isLast,
  });

  final Experience experience;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
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
                    color: skin.timelineLine,
                  ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        experience.isCurrent ? skin.accent : skin.surfaceHigh,
                    border: Border.all(
                      color: experience.isCurrent
                          ? skin.accent
                          : skin.cardBorder,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: skin.timelineLine,
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
                color: skin.cardBackground,
                border: Border.all(color: skin.cardBorder),
                borderRadius: BorderRadius.circular(3),
                boxShadow: skin.cardShadow,
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
                    decoration: BoxDecoration(
                      color: skin.cardHeaderBackground,
                      border: Border(bottom: BorderSide(color: skin.divider)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            experience.role,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: skin.headingWeight,
                              color: skin.headingColor,
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
                              color: skin.hoverBackground,
                              border: Border.all(color: skin.accent),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              'Current',
                              style: TextStyle(
                                fontSize: 10,
                                color: skin.accent,
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
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: skin.accent,
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
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: skin.textPrimary,
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.arrow_right,
                                      size: 14,
                                      color: skin.accent,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      h,
                                      style: TextStyle(
                                        fontSize: 11,
                                        height: 1.4,
                                        color: skin.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                  (skill) => _SkillChip(label: skill),
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

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: skin.chipBackground,
        border: Border.all(color: skin.chipBorder),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: skin.chipText),
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
    final skin = SkinPalette.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: skin.iconMuted),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: skin.iconMuted),
        ),
      ],
    );
  }
}
