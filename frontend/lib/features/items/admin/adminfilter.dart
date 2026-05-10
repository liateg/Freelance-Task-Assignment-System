import 'package:flutter/material.dart';

class AdminFilter extends StatefulWidget {
  @override
  _AdminFilterState createState() => _AdminFilterState();
}

class _AdminFilterState extends State<AdminFilter> {
  String search = "";
  String type = "All";

  List items = [
    {"name": "Wallet", "type": "Wallet"},
    {"name": "Laptop", "type": "Electronics"},
    {"name": "Bag", "type": "Bag"},
  ];

  @override
  Widget build(BuildContext context) {
    List show = [];

    for (var item in items) {
      if (item["name"]
              .toLowerCase()
              .contains(search.toLowerCase()) &&
          (type == "All" || item["type"] == type)) {
        show.add(item);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xfff7f5f2),

      appBar: AppBar(
        backgroundColor: Color(0xfff7f5f2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search item...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),

            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton(
                value: type,
                isExpanded: true,
                underline: SizedBox(),
                items: [
                  "All",
                  "Wallet",
                  "Electronics",
                  "Bag"
                ].map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                },
              ),
            ),

            SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: show.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),

                      leading: CircleAvatar(
                        backgroundColor: Colors.green[100],
                        child: Icon(
                          Icons.inventory,
                          color: Colors.green[900],
                        ),
                      ),

                      title: Text(
                        show[index]["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(show[index]["type"]),

                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}