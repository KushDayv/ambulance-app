import 'package:flutter/material.dart';
import 'firstaidbruise.dart';
import 'firstaidburn.dart';
import 'firstaidchoke.dart';
import 'firstaiddeepcut.dart';
import 'firstaidfainting.dart';
import 'firstaidfoodpoisoning.dart';
import 'firstaidfracture.dart';
import 'firstaidsnakebite.dart';
import 'firstaiddislocation.dart';
import 'firstaidacidburn.dart';

class FirstAidDetails extends StatelessWidget {

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  const FirstAidDetails({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Aid',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details for First Aid',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FirstAidItem(
                      title: 'Burn',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BurnDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Food Poisoning',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodPoisoningDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Deep Cut',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeepCutDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Bruise',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BruiseDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Choke',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChokeDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Snake Bite',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SnakeBiteDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Fracture',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FractureDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Fainting',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FaintingDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Dislocation',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DislocationDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                    FirstAidItem(
                      title: 'Acid Burn',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AcidBurnDetails(scaffoldKey: scaffoldKey)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstAidItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const FirstAidItem({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 30,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
