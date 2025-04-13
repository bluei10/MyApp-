import 'package:flutter/material.dart';

void main() {
  runApp(BookClubApp());
}

class BookClubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> demoClubs = [
    {
      'title': 'Discussing "1984" by George Orwell',
      'club': 'Dystopia Readers',
      'members': 124,
      'avatars': ["A", "B", "C"]
    },
    {
      'title': 'Poetry Night: Rumi & Tagore',
      'club': 'Soulful Poets',
      'members': 89,
      'avatars': ["D", "E", "F"]
    },
    {
      'title': 'Fantasy Book Recap: LOTR',
      'club': 'Middle-Earth Talk',
      'members': 142,
      'avatars': ["G", "H", "I"]
    },
  ];

  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showNewClubForm(BuildContext context) {
    final titleController = TextEditingController();
    final clubNameController = TextEditingController();
    final membersController = TextEditingController();
    final avatarsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create New Club",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Event Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: clubNameController,
                  decoration: const InputDecoration(
                    labelText: 'Club Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: membersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Member Count',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: avatarsController,
                  decoration: const InputDecoration(
                    labelText: 'Avatars (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final club = clubNameController.text.trim();
                    final members = int.tryParse(membersController.text.trim()) ?? 0;
                    final avatars = avatarsController.text.trim().split(',');

                    if (title.isNotEmpty && club.isNotEmpty) {
                      setState(() {
                        demoClubs.add({
                          'title': title,
                          'club': club,
                          'members': members,
                          'avatars': avatars.map((e) => e.trim()).toList(),
                        });
                      });
                      Navigator.pop(context);
                      showSnack(context, 'New club "$club" added!');
                    } else {
                      showSnack(context, 'Please fill in all required fields.');
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Add Club"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📚 BOOK CLUBS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.purple[800],
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Bluei10'),
              accountEmail: Text('nand@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-3Y5gO2V8u7VoVdxv_9Y9CtcG_TNgVeLBGw&s'),
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
              onTap: () => showSnack(context, 'About feature coming soon!'),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: demoClubs.length,
        itemBuilder: (context, index) {
          final club = demoClubs[index];
          return GestureDetector(
            child: Hero(
              tag: club['title'],
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[900],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    title: Text(
                      club['title'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        '${club['club']} • ${club['members']} members',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 70,
                      child: Stack(
                        children: List.generate(club['avatars'].length, (i) {
                          return Positioned(
                            left: i * 20.0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.purple[200],
                              child: Text(
                                club['avatars'][i],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) => ClubDetailPage(club: club),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purpleAccent,
        icon: const Icon(Icons.add),
        label: const Text("New Club"),
        onPressed: () => showNewClubForm(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: (index) {
          final labels = ['Home', 'Search', 'Messages'];
          showSnack(context, '${labels[index]} tapped!');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        ],
      ),
    );
  }
}

class ClubDetailPage extends StatelessWidget {
  final Map<String, dynamic> club;

  const ClubDetailPage({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text(club['club']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Hero(
          tag: club['title'],
          child: Material(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club['title'],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Club: ${club['club']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${club['members']} members',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Members:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(club['avatars'].length, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.purple[300],
                          child: Text(
                            club['avatars'][i],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
