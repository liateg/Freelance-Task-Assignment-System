import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String filter = "All";
  String location = "All";
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Items"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search item...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: filter,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "All",
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: "Electronics",
                        child: Text("Electronics"),
                      ),
                      DropdownMenuItem(
                        value: "Accessories",
                        child: Text("Accessories"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filter = value!;
                      });
                    },
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: location,
                    decoration: InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "All",
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: "Library",
                        child: Text("Library"),
                      ),
                      DropdownMenuItem(
                        value: "Campus",
                        child: Text("Campus"),
                      ),
                      DropdownMenuItem(
                        value: "Cafeteria",
                        child: Text("Cafeteria"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        location = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: [
                  if ((filter == "All" || filter == "Accessories") &&
                      (location == "All" || location == "Campus") &&
                      "Cream Canvas Tote Bag"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.shopping_bag),
                        title: Text("Cream Canvas Tote Bag"),
                        subtitle: Text("Accessories - Campus"),
                      ),
                    ),

                  if ((filter == "All" || filter == "Accessories") &&
                      (location == "All" || location == "Library") &&
                      "Pink Bracelet"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.watch),
                        title: Text("Pink Bracelet"),
                        subtitle: Text("Accessories - Library"),
                      ),
                    ),

                  if ((filter == "All" || filter == "Accessories") &&
                      (location == "All" || location == "Library") &&
                      "Green Bead Bracelet"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.watch),
                        title: Text("Green Bead Bracelet"),
                        subtitle: Text("Accessories - Library"),
                      ),
                    ),

                  if ((filter == "All" || filter == "Accessories") &&
                      (location == "All" || location == "Cafeteria") &&
                      "Black Bottle"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.local_drink),
                        title: Text("Black Bottle"),
                        subtitle: Text("Accessories - Cafeteria"),
                      ),
                    ),

                  if ((filter == "All" || filter == "Electronics") &&
                      (location == "All" || location == "Campus") &&
                      "Gray Laptop"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.laptop),
                        title: Text("Gray Laptop"),
                        subtitle: Text("Electronics - Campus"),
                      ),
                    ),

                  if ((filter == "All" || filter == "Electronics") &&
                      (location == "All" || location == "Library") &&
                      "White Apple AirPods Case"
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.headphones),
                        title: Text("White Apple AirPods Case"),
                        subtitle: Text("Electronics - Library"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}