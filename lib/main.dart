import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:webex(),debugShowCheckedModeBanner: false,));
}


class webex extends StatefulWidget {
  const webex({super.key});

  @override
  State<webex> createState() => _webexState();
}

class _webexState extends State<webex> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Courses App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CoursesHomePage(),
    );
  }
}

class CoursesHomePage extends StatefulWidget {
  const CoursesHomePage({super.key});

  @override
  State<CoursesHomePage> createState() =>
      _CoursesHomePageState();
}

class _CoursesHomePageState extends State<CoursesHomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> courses = [
    {
      'name': 'Flutter Development',
      'description': 'Build Android, iOS and web apps.',
      'icon': Icons.phone_android,
      'color': Colors.blue,
    },
    {
      'name': 'Web Development',
      'description': 'Learn HTML, CSS and JavaScript.',
      'icon': Icons.language,
      'color': Colors.orange,
    },
    {
      'name': 'Python Programming',
      'description': 'Learn Python from the basics.',
      'icon': Icons.code,
      'color': Colors.green,
    },
    {
      'name': 'UI/UX Design',
      'description': 'Design beautiful user interfaces.',
      'icon': Icons.design_services,
      'color': Colors.purple,
    },
    {
      'name': 'Database',
      'description': 'Learn SQL and database concepts.',
      'icon': Icons.storage,
      'color': Colors.red,
    },
    {
      'name': 'Artificial Intelligence',
      'description': 'Explore AI and machine learning.',
      'icon': Icons.smart_toy,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // HEADER
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'My Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.school, size: 28),
          ),
        ],
      ),

      // BODY: HEADER MESSAGE AND COURSES
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Welcome to Learning!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore courses and improve your skills.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Available Courses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // RESPONSIVE COURSE GRID
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth >= 900
                      ? 3
                      : constraints.maxWidth >= 550
                      ? 2
                      : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 190,
                    ),
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Icon(
                                course['icon'] as IconData,
                                size: 38,
                                color: course['color'] as Color,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                course['name'] as String,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  course['description'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'You selected ${course['name']}',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Explore'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // FOOTER: BOTTOM NAVIGATION
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index != 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  index == 0 ? 'Home selected' : 'Profile selected',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
