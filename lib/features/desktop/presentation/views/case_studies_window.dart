import 'package:flutter/material.dart';
import 'package:portfolio/features/desktop/data/case_studies_data.dart';
import 'package:portfolio/features/desktop/domain/entity/case_study.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

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
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const Win7SectionHeader(title: 'Case Studies'),
          Container(height: 1, color: _kWin7CardBorder),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kWin7CardBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: _kWin7SectionBg,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  study.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kWin7DarkHeader,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  study.summary,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Color(0xFF333333),
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
                        color: Colors.blue.shade700,
                      ),
                    ),
                    Icon(Icons.arrow_forward,
                        size: 12, color: Colors.blue.shade700),
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
                Icon(Icons.arrow_back, size: 13, color: Colors.blue.shade700),
                const SizedBox(width: 4),
                Text(
                  'All case studies',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            study.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.3,
              color: _kWin7DarkHeader,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            study.summary,
            style: const TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              height: 1.45,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 16),
          _section('Context', [study.context]),
          _section('Problem', [study.problem]),
          if (study.investigation.isNotEmpty)
            _section('Investigation', study.investigation),
          if (study.decisions.isNotEmpty)
            _section('Technical decisions', study.decisions),
          if (study.implementation.isNotEmpty)
            _section('Implementation', study.implementation),
          for (final block in study.evidence) ...[
            const SizedBox(height: 14),
            _EvidenceWidget(block: block),
          ],
          if (study.results.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Text(
              'Results',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _kWin7DarkHeader,
              ),
            ),
            const SizedBox(height: 8),
            MetricStrip(metrics: study.results),
          ],
          if (study.lesson != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kWin7SectionBg,
                border: Border.all(color: _kWin7CardBorder),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What I learned',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: _kWin7DarkHeader,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    study.lesson!,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
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
                        color: const Color(0xFFF0F4F8),
                        border: Border.all(color: const Color(0xFF9BB8D0)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        tech,
                        style: const TextStyle(
                            fontSize: 10, color: Color(0xFF2567A5)),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _section(String title, List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _kWin7DarkHeader,
          ),
        ),
        const SizedBox(height: 6),
        for (final paragraph in paragraphs)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              paragraph,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.55,
                color: Color(0xFF1A1A1A),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (block.title != null)
          Text(
            block.title!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF444444),
            ),
          ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: block.type == EvidenceType.code || block.type == EvidenceType.log
                ? const Color(0xFF1E1E1E)
                : _kWin7SectionBg,
            border: Border.all(color: _kWin7CardBorder),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            block.content,
            style: TextStyle(
              fontSize: 11.5,
              height: 1.45,
              fontFamily: block.type == EvidenceType.code ||
                      block.type == EvidenceType.log || block.type == EvidenceType.diagram
                  ? 'monospace'
                  : null,
              color: block.type == EvidenceType.code ||
                      block.type == EvidenceType.log
                  ? const Color(0xFFD4D4D4)
                  : const Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
}
