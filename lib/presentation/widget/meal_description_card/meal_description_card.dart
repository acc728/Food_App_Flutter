import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MealDescriptionCard extends StatelessWidget {
  const MealDescriptionCard({super.key, this.meal});

  final Meal? meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.timelapse),
                  SizedBox(width: 8),
                  Text(
                    "Instructions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              if (meal != null && meal!.strYoutube!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        launchUrlString(meal!.strYoutube!);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black),
                      child: const Row(
                        children: [Icon(Icons.play_arrow), Text("Video")],
                      )),
                ),
            ],
          ),
        ),
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal?.strInstructions ?? "Description not found",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
