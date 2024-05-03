import 'package:flutter/material.dart';

class DetailListTile extends StatelessWidget {
  const DetailListTile({
    super.key,
    required this.data,
    required this.formatDated,
  });

  final Map<String, dynamic> data;
  final String formatDated;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              data["name"],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
              child: Text(
            formatDated,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
          ))
        ],
      ),
      subtitle: Text(
        data["id_number"],
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }
}
