import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/data/case_studies_data.dart';
import 'package:portfolio/features/desktop/domain/entity/case_study.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';

/// Case studies window: master list of studies; tapping one opens the
/// full story (context → problem → investigation → decisions → results).
class CaseStudiesWindow extends StatefulWidget {
  const CaseStudiesWindow({super.key});

  @override
  State<CaseStudiesWindow> createState() => _CaseStudiesWindowState();
}

class _CaseStudiesWindowState extends State<CaseStudiesWindow> {
  CaseStudy? _selected;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'Case Studies'),
          Container(height: 1, color: skin.divider),
          Expanded(
            child: _selected == null
                ? _buildList()
                : _CaseStudyDetail(
                    study: _selected!,
                    onBack: () => setState(() => _selected = null),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: caseStudies.length,
      itemBuilder: (context, index) =>
          _CaseStudyListTile(study: caseStudies[index], onTap: () {
        setState(() => _selected = caseStudies[index]);
      }),
    );
  }
}

class _CaseStudyListTile extends StatelessWidget {
  const _CaseStudyListTile({required this.study, required this.onTap});

  final CaseStudy study;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: skin.cardBackground,
        border: Border.all(color: skin.cardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: skin.hoverBackground,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  study.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: skin.headingWeight,
                    color: skin.headingColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  study.summary,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: skin.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Read case study',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: skin.accent,
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: 12, color: skin.accent),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CaseStudyDetail extends StatelessWidget {
  const _CaseStudyDetail({required this.study, required this.onBack});

  final CaseStudy study;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, size: 13, color: skin.accent),
                const SizedBox(width: 4),
                Text(
                  'All case studies',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: skin.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            study.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: skin.headingWeight,
              height: 1.3,
              color: skin.headingColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            study.summary,
            style: TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              height: 1.45,
              color: skin.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          _section(context, 'Context', [study.context]),
          _section(context, 'Problem', [study.problem]),
          if (study.investigation.isNotEmpty)
            _section(context, 'Investigation', study.investigation),
          if (study.decisions.isNotEmpty)
            _section(context, 'Technical decisions', study.decisions),
          if (study.implementation.isNotEmpty)
            _section(context, 'Implementation', study.implementation),
          for (final block in study.evidence) ...[
            const SizedBox(height: 14),
            _EvidenceWidget(block: block),
          ],
          if (study.lesson != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: skin.cardHeaderBackground,
                border: Border.all(color: skin.cardBorder),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What I learned',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: skin.headingColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    study.lesson!,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: skin.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          Wrap(
            spacing: 5,
            runSpacing: 4,
            children: study.technologies
                .map((tech) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: skin.chipBackground,
                        border: Border.all(color: skin.chipBorder),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        tech,
                        style:
                            TextStyle(fontSize: 10, color: skin.chipText),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<String> paragraphs) {
    final skin = SkinPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: skin.headingWeight,
            color: skin.headingColor,
          ),
        ),
        const SizedBox(height: 6),
        for (final paragraph in paragraphs)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              paragraph,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.55,
                color: skin.textPrimary,
              ),
            ),
          ),
      ],
    );
  }
}

class _EvidenceWidget extends StatelessWidget {
  const _EvidenceWidget({required this.block});

  final EvidenceBlock block;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    final isMonospace = block.type == EvidenceType.code ||
        block.type == EvidenceType.log ||
        block.type == EvidenceType.diagram;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (block.title != null)
          Text(
            block.title!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: skin.textTertiary,
            ),
          ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: block.type == EvidenceType.code || block.type == EvidenceType.log
                ? skin.codeBackground
                : skin.cardHeaderBackground,
            border: Border.all(color: skin.cardBorder),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            block.content,
            style: TextStyle(
              fontSize: 11.5,
              height: 1.45,
              fontFamily: isMonospace ? 'monospace' : null,
              color: block.type == EvidenceType.code ||
                      block.type == EvidenceType.log
                  ? skin.codeText
                  : skin.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
