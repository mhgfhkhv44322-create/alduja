import 'package:flutter/material.dart';

class AnonymousMessageScreen extends StatefulWidget {
  const AnonymousMessageScreen({super.key});

  @override
  State<AnonymousMessageScreen> createState() =>
      _AnonymousMessageScreenState();
}

class _AnonymousMessageScreenState
    extends State<AnonymousMessageScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFDCC08D),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'إرسال رسالة مجهولة',
          style: TextStyle(
            color: Color(0xFFE8C98F),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1014),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF292F33)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF181C20),
                      border: Border.all(
                        color: const Color(0xFF9B7A48),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.send_outlined,
                      color: Color(0xFFE4C58E),
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'اكتب ما تريد إرساله ..',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xFFE3D4B8),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'مجهوليتك هي حريتك',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xFF88847C),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 230,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0F13),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF292F33)),
              ),
              child: TextField(
                controller: controller,
                maxLength: 1000,
                maxLines: null,
                expands: true,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFFE8E0D2),
                  fontSize: 15,
                ),
                decoration: const InputDecoration(
                  hintText: 'اكتب رسالتك هنا ..',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(color: Color(0xFF666762)),
                  border: InputBorder.none,
                  counterStyle: TextStyle(color: Color(0xFF666762)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            _info(Icons.visibility_off_outlined, 'مجهول تماماً',
                'لن يظهر اسمك أو أي معلومات عنك'),
            const SizedBox(height: 10),
            _info(Icons.shield_outlined, 'بيئة آمنة',
                'نحترم خصوصيتك ونحمي رسائلك'),
            const SizedBox(height: 10),
            _info(Icons.people_outline, 'رسالتك تصل إلى شخص',
                'يمكن أن تترك أثراً في عالم الدجى'),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE4C58E),
                  foregroundColor: const Color(0xFF17120C),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'بدء الكتابة',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1014),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF22292E)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD7B97E), size: 25),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Color(0xFFDCCBAE),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: Color(0xFF77756F),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
