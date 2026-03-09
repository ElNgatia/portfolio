import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/experience_data.dart';
import 'package:portfolio/features/desktop/domain/entity/experience.dart';

class ExperienceWindow extends StatelessWidget {
  const ExperienceWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Work Experience',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ExperienceCard(
                experience: workExperience[index],
                isFirst: index == 0,
                isLast: index == workExperience.length - 1,
              ),
              childCount: workExperience.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                    color: colorScheme.outlineVariant,
                  ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: experience.isCurrent
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    border: Border.all(
                      color: experience.isCurrent
                          ? colorScheme.primary
                          : colorScheme.outline,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isFirst) const SizedBox(height: 12),
                  // Role + current badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.role,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (experience.isCurrent)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Current',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Company
                  Text(
                    experience.company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Meta row
                  Wrap(
                    spacing: 12,
                    runSpacing: 2,
                    children: [
                      _MetaChip(
                        icon: Icons.calendar_today_outlined,
                        label: experience.duration,
                      ),
                      if (experience.location != null)
                        _MetaChip(
                          icon: Icons.location_on_outlined,
                          label: experience.location!,
                        ),
                      if (experience.employmentType != null)
                        _MetaChip(
                          icon: Icons.work_outline,
                          label: experience.employmentType!,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Description
                  Text(
                    experience.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  // Highlights
                  if (experience.highlights.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    ...experience.highlights.map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.arrow_right,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                h,
                                style: theme.textTheme.bodySmall,
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
                      spacing: 6,
                      runSpacing: 4,
                      children: experience.skills
                          .map(
                            (skill) => Chip(
                              label: Text(
                                skill,
                                style: theme.textTheme.bodySmall,
                              ),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
