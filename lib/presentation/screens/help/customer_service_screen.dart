import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class _ChatMessage {
  _ChatMessage({
    required this.text,
    required this.fromUser,
    DateTime? sentAt,
  }) : sentAt = sentAt ?? DateTime.now();

  final String text;
  final bool fromUser;
  final DateTime sentAt;
}

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _typing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addBotMessage(context.l10n.customerServiceWelcome);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _typing = true;
    });
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _messages.add(_ChatMessage(text: text, fromUser: false));
        _typing = false;
      });
      _scrollToBottom();
    });
  }

  void _send([String? quickText]) {
    final raw = (quickText ?? _controller.text).trim();
    if (raw.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: raw, fromUser: true));
      _controller.clear();
    });
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _addBotMessage(_botResponseFor(raw));
    });
  }

  String _botResponseFor(String input) {
    final l = context.l10n;
    final lower = input.toLowerCase();
    if (lower.contains('order') ||
        lower.contains('commande') ||
        lower.contains('comment')) {
      return 'To place an order, open a product page, choose your delivery '
          'address and Mobile Money payment method, then tap «Buy now».';
    }
    if (lower.contains('refund') || lower.contains('rembours')) {
      return 'Refund requests are processed within 48h. Open the order, tap '
          '«Report an issue» and our team will get back to you.';
    }
    if (lower.contains('payment') || lower.contains('paie')) {
      return 'For payment issues, please make sure your Mobile Money account '
          'has sufficient balance. If the issue persists, share your order '
          'number so I can escalate.';
    }
    if (lower.contains('human') || lower.contains('humain')) {
      return 'Our human support is available Mon–Fri 9am–6pm. '
          'Please share your concern and a Zolya agent will reply shortly.';
    }
    return l.customerServiceWelcome;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;
    final fillColor = isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;
    final l = context.l10n;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.customerServiceTitle, centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              itemCount: _messages.length + (_typing ? 1 : 0),
              itemBuilder: (_, i) {
                if (_typing && i == _messages.length) {
                  return _TypingIndicator(
                    label: l.customerServiceTyping,
                    mutedColor: mutedColor,
                    fillColor: fillColor,
                  );
                }
                final m = _messages[i];
                return _ChatBubble(
                  message: m,
                  scheme: scheme,
                  fillColor: fillColor,
                ).animate().fadeIn(duration: 200.ms);
              },
            ),
          ),
          if (_messages.length <= 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _QuickReply(
                      label: l.customerServiceQuickHowOrder,
                      onTap: () => _send(l.customerServiceQuickHowOrder),
                    ),
                    _QuickReply(
                      label: l.customerServiceQuickRefund,
                      onTap: () => _send(l.customerServiceQuickRefund),
                    ),
                    _QuickReply(
                      label: l.customerServiceQuickPayment,
                      onTap: () => _send(l.customerServiceQuickPayment),
                    ),
                    _QuickReply(
                      label: l.customerServiceQuickHuman,
                      onTap: () => _send(l.customerServiceQuickHuman),
                    ),
                  ],
                ),
              ),
            ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                ZolyaSpacing.lg,
                ZolyaSpacing.sm,
                ZolyaSpacing.lg,
                ZolyaSpacing.md,
              ),
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(
                  top: BorderSide(color: borderColor.withValues(alpha: 0.5)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ZolyaSpacing.md + 2,
                        vertical: ZolyaSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius:
                            BorderRadius.circular(ZolyaRadius.full),
                      ),
                      child: TextField(
                        controller: _controller,
                        cursorColor: scheme.onSurface,
                        style: ZolyaTypography.body
                            .copyWith(color: scheme.onSurface),
                        decoration: InputDecoration.collapsed(
                          hintText: l.customerServiceHint,
                          hintStyle: ZolyaTypography.body
                              .copyWith(color: mutedColor),
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                  ),
                  const SizedBox(width: ZolyaSpacing.sm),
                  Material(
                    color: scheme.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: _send,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(ZolyaSpacing.md),
                        child: Icon(LucideIcons.send,
                            color: scheme.onPrimary, size: 18),
                      ),
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

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    required this.scheme,
    required this.fillColor,
  });

  final _ChatMessage message;
  final ColorScheme scheme;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    final isUser = message.fromUser;
    final bg = isUser ? scheme.primary : fillColor;
    final fg = isUser ? scheme.onPrimary : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.sm),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                gradient: ZolyaGradients.or,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(LucideIcons.bot, size: 16, color: ZolyaColors.noir),
            ),
            const SizedBox(width: ZolyaSpacing.sm),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: ZolyaSpacing.md,
                vertical: ZolyaSpacing.sm + 2,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(ZolyaRadius.md),
                  topRight: const Radius.circular(ZolyaRadius.md),
                  bottomLeft: Radius.circular(isUser ? ZolyaRadius.md : 4),
                  bottomRight: Radius.circular(isUser ? 4 : ZolyaRadius.md),
                ),
              ),
              child: Text(
                message.text,
                style: ZolyaTypography.body.copyWith(color: fg, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator({
    required this.label,
    required this.mutedColor,
    required this.fillColor,
  });
  final String label;
  final Color mutedColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZolyaSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: ZolyaGradients.or,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child:
                const Icon(LucideIcons.bot, size: 16, color: ZolyaColors.noir),
          ),
          const SizedBox(width: ZolyaSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.md,
              vertical: ZolyaSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(ZolyaRadius.md),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ZolyaSpinner(size: ZolyaSpinnerSize.sm),
                const SizedBox(width: ZolyaSpacing.sm),
                Text(
                  label,
                  style:
                      ZolyaTypography.bodySmall.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickReply extends StatelessWidget {
  const _QuickReply({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final borderColor = isLight ? ZolyaColors.bordure : ZolyaColors.bordureDark;

    return Padding(
      padding: const EdgeInsets.only(right: ZolyaSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ZolyaRadius.full),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ZolyaSpacing.md,
              vertical: ZolyaSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(ZolyaRadius.full),
              border: Border.all(color: borderColor),
            ),
            child: Text(
              label,
              style: ZolyaTypography.bodySmall.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
