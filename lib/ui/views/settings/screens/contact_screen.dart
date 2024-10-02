import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/common.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          "contact_us".translate(),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ContactUsListTile(
                url: 'https://www.facebook.com/profile.php?id=100068813316337',
                platform: "facebook".translate(),
                icon: Ionicons.logo_facebook,
              ),
              ContactUsListTile(
                url: 'https://wa.me/201227171323',
                platform: "whatsApp".translate(),
                icon: Ionicons.logo_whatsapp,
              ),
              ContactUsListTile(
                url: 'https://www.khaled-mohamad.tech',
                platform: "website".translate(),
                icon: Icons.web_asset,
              ),
              ContactUsListTile(
                url: 'https://twitter.com',
                platform: "twitter".translate(),
                icon: Ionicons.logo_twitter,
              ),
              ContactUsListTile(
                url: 'https://www.instagram.com',
                platform: "instagram".translate(),
                icon: Ionicons.logo_instagram,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactUsListTile extends StatelessWidget {
  const ContactUsListTile({
    super.key,
    required this.url,
    required this.platform,
    required this.icon,
  });
  final String url;
  final String platform;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: ListTile(
        minVerticalPadding: 18,
        onTap: () {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
        tileColor: kcCartItemBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveIcon(
              icon,
              color: kcPrimaryColor,
            ),
            horizontalSpaceMedium,
            ResponsiveText(
              platform,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
