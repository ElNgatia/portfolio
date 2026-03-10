import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

// Windows 7 Aero palette
const _kWin7DarkHeader = Color(0xFF0A246A);
const _kWin7CardBorder = Color(0xFFADCDEF);
const _kWin7SectionBg = Color(0xFFEFF4FB);

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
              'Resume',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(height: 1, color: _kWin7CardBorder),

          // PDF viewer
          Expanded(
            child: Container(
              color: _kWin7SectionBg,
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
