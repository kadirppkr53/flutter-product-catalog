import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discover",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ), 
                ),

                IconButton(
                onPressed: (){}, 
                iconSize: 32,
                icon: Icon(Icons.shopping_bag_outlined)
                )
            ],
          ),

          SizedBox(height: 8),

          Text("Find your perfect device",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
           ),

           SizedBox(height: 14,),

           Container(
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Products",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey,),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
           ),

           SizedBox(height: 12,),

           Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image:NetworkImage(
              "https://p4.wallpaperbetter.com/wallpaper/488/549/69/technology-internet-business-scheme-wallpaper-preview.jpg"            
             ),
             fit: BoxFit.cover
             )
            ),
           ),
        ],
        ),
       )
      ),
    );
  }
}