import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_tab_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatefulWidget {
  final StudioDetails studioDetails;
  final List<AgentModel> agentModels;
  const AboutTab({
    Key? key,
    required this.studioDetails,
    required this.agentModels,
  }) : super(key: key);

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    List<String> tags = widget.studioDetails.tags;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 30,
            width: double.maxFinite,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CustomTagBuilder(tag: tags[index]),
                );
              },
              itemCount: tags.length,
            ),
          ),
          _descriptionBuilder(),
          _agentCardBuilder(widget.agentModels)
        ],
      ),
    );
  }

  _descriptionBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            widget.studioDetails.description,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorAssets.lightGray,
                fontSize: 14),
          ),
        ],
      ),
    );
  }

  _agentCardBuilder(List<AgentModel> models) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
          borderRadius: BorderRadius.circular(6),
          color: ColorAssets.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Listing Agent',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorAssets.blackFaded),
          ),
          for (var i in models)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: color.secondary,
                backgroundImage: MemoryImage(i.photoUrl),
                radius: 20,
              ),
              title: Text(
                i.name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorAssets.blackFaded),
              ),
              subtitle: Text(
                i.status,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorAssets.lightGray),
              ),
              // trailing: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Container(
              //       width: 30,
              //       height: 30,
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: ColorAssets.white,
              //           boxShadow: [
              //             BoxShadow(
              //                 color: ColorAssets.lightGray.withOpacity(0.5),
              //                 blurRadius: 1)
              //           ]),
              //       child: Icon(
              //         Icons.call,
              //         size: 20,
              //         color: color.primary,
              //       ),
              //     ).onTap(() {
              //       launchUrl(Uri.parse('tel:${i.phoneNumber}'));
              //     }),
              //     const SizedBox(width: 15),
              //     Container(
              //       width: 30,
              //       height: 30,
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: ColorAssets.white,
              //           boxShadow: [
              //             BoxShadow(
              //                 color: ColorAssets.lightGray.withOpacity(0.5),
              //                 blurRadius: 1)
              //           ]),
              //       child: Icon(
              //         Icons.message_rounded,
              //         size: 20,
              //         color: color.primary,
              //       ),
              //     ).onTap(() {
              //       // context.push(ChatView.routePath, extra: {'agent_model': i});
              //     }),
              //   ],
              // ),
            )
        ],
      ),
    );
  }
}
