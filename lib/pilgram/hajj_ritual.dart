import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles.dart';
import 'list_data_model.dart';

class ListItemDetails extends StatelessWidget {
  final ListDatalModel model;

  const ListItemDetails(this.model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(AppLocalizations.of(context)!.appName)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              _imageView(context),
              _description(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            model.name.toString(),
            style: GoogleFonts.cairo(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  _imageView(context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          height: 160.0,
          width: 290.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(model.imagePath.toString()),
          ),
        ),
      ],
    );
  }

  _description(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          child: Text(
            model.about.toString(),
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class HajjRitualListPage extends StatefulWidget {
  final List<ListDatalModel> list;
  const HajjRitualListPage(this.list, {Key? key}) : super(key: key);
  @override
  HajjRitualListState createState() {
    return HajjRitualListState();
  }
}

class HajjRitualListState extends State<HajjRitualListPage> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(AppLocalizations.of(context)!.appName)),
        body: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListItemDetails(widget.list[index])));
                      },
                      title: Text(
                        '${widget.list[index].name}',
                        style: ThemeText.LisTextTitle,
                      ),
                      subtitle: Text('${widget.list[index].shortDesc}'),
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('${widget.list[index].imagePath}')),
                      trailing: Icon(Icons.ac_unit)));
            }));
  }
}
