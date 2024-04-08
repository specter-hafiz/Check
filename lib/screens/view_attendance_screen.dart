import 'package:check/components/colors.dart';
import 'package:check/components/data.dart';
import 'package:check/config/size_config.dart';
import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatelessWidget {
  const ViewAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Attendance"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 1),
          itemCount: info.length,
          itemBuilder: (context, index) => Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    info[index]["title"],
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(info[index]["dates"]),
                  trailing: Text(
                    info[index]["number"].toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.blueText, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
    );
  }
}
