import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:portfolio/features/desktop/presentation/widgets/metric_strip.dart';
import 'package:pdfx/pdfx.dart';

const _kResumeAssetPath = 'assets/files/elvis_ngatia.pdf';

class ResumeWindow extends StatefulWidget {
  const ResumeWindow({super.key});

  @override
  State<ResumeWindow> createState() => _ResumeWindowState();
}

class _ResumeWindowState extends State<ResumeWindow> {
  late final PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(_kResumeAssetPath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Container(
      color: skin.pageBackground,
      child: Column(
        children: [
          const WindowSectionHeader(title: 'Resume'),

          Container(height: 1, color: skin.divider),

          // PDF viewer
          Expanded(
            child: Container(
              color: skin.cardHeaderBackground,
              child: PdfViewPinch(
                controller: _pdfController,
                builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  documentLoaderBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  pageLoaderBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (_, error) => Center(
                    child: Text(
                      'Failed to load resume: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
