import 'package:flutter/material.dart';
import 'package:flutter_application/Records/records.dart';
import 'package:flutter_application/Utils/widget_util.dart';
import 'package:provider/provider.dart';
import '../Settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Utils/request.dart';

class DentalRecordsPage extends StatefulWidget {
  const DentalRecordsPage({Key? key}) : super(key: key);

  @override
  DentalRecordsPageState createState() => DentalRecordsPageState();
}

class DentalRecordsPageState extends State<DentalRecordsPage> {
  String patientName = "Patient Name";
  List<Records> records = [];

  @override
  void initState() {
    super.initState();
    Request.getPatientName().then((value) {
      setState(() {
        patientName = value;
      });
      Request.getRecordsbyPatientId().then((value) {
        setState(() {
          records = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<SettingProvider>(
        builder: (context, settingProvider, child) {
      return Scaffold(
          appBar: WidgetUtil.buildNavBar(
              context,
              screenWidth,
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary),
          body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(settingProvider.isDarkMode
                      ? 'assets/background-dark.jpg'
                      : 'assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(AppLocalizations.of(context)!.dental_records_title,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "suezone",
                          fontWeight: FontWeight.bold,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                        )),
                    Text(patientName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "suezone",
                          fontWeight: FontWeight.bold,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    if (records.isEmpty)
                      Text(
                        AppLocalizations.of(context)!.dental_records_no_records,
                      ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...getRecordsTiles(records),
                        ],
                      ),
                    ))
                  ])));
    });
  }

  List<Widget> getRecordsTiles(List<Records> records) {
    return records.map((record) {
      return Container(
        width: 600,
        alignment: Alignment.center,
        child: ExpansionTile(
          iconColor: Theme.of(context).colorScheme.onPrimary,
          collapsedBackgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          collapsedTextColor: Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          title:
              Text(record.date, style: const TextStyle(fontFamily: "suezone")),
          children: [
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.dental_records_notes,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: "suezone",
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                record.notes,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: "suezone",
                ),
              ),
            ),
            ListTile(
              title: Text(
                "- ${record.doctorName}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: "suezone",
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
