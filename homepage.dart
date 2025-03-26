import 'dart:async';
import 'package:flutter/material.dart';
import 'personal_details.dart';
import 'disease_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final Function() onViewProfile;

  HomePage({
    required this.userName,
    required this.userEmail,
    required this.onViewProfile,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> messages = [
    "Consistency: Regular application is key to controlling plant diseases.",
    "Timing: Apply treatments early in the morning or late in the evening to prevent leaf burn.",
    "Coverage: Ensure thorough coverage of affected plant parts.",
    "Storage: Prepare small batches of organic pesticides as they are most effective when fresh."
  ];

  final List<Map<String, String>> diseases = [
    {
      'title': 'Black Spot',
      'image': 'assets/black_spot.webp',
      'symptoms': 'Black, circular spots on leaves, often surrounded by yellow areas.',
      'precautions': '''
1. Plant resistant varieties.
2. Remove and destroy infected leaves.
3. Water plants at the base to keep foliage dry.
4. Ensure good air circulation around plants.''',
      'organicPesticides': '''
Apple Cider Vinegar Spray:
Ingredients: 3 tablespoons apple cider vinegar, 1 gallon water.
Preparation: Mix vinegar and water. Spray on affected plants every 7-10 days.

Garlic Spray:
Ingredients: 10-12 cloves garlic, 1 quart water, 1 teaspoon liquid soap.
Preparation: Blend garlic with water, let sit overnight, strain, and add soap. Spray on affected plants every 7-10 days.
''',
    },
    {
      'title': 'Powdery Mildew',
      'image': 'assets/powder_mild.webp',
      'symptoms': 'White powdery spots on leaves and stems.',
      'precautions': '''
1. Plant resistant varieties.
2. Ensure good air circulation around plants.
3. Avoid overhead watering.
4. Remove and destroy infected leaves.''',
      'organicPesticides': '''
Baking Soda Spray:
Ingredients: 1 tablespoon baking soda, 1/2 teaspoon liquid soap, 1 gallon water.
Preparation: Mix all ingredients. Spray on affected plants every 7-10 days.

Neem Oil Spray:
Ingredients: 2 tablespoons neem oil, 1 teaspoon liquid soap, 1 gallon water.
Preparation: Mix all ingredients. Spray on affected plants every 7-10 days.
''',
    },
    {
      'title': 'Rust',
      'image': 'assets/rust.webp',
      'symptoms': 'Orange or yellow spots on leaves, often with a powdery appearance.',
      'precautions': '''
1. Plant resistant varieties.
2. Remove and destroy infected leaves.
3. Water plants at the base to keep foliage dry.
4. Ensure good air circulation around plants.''',
      'organicPesticides': '''
Sulfur Spray:
Ingredients: 1 tablespoon sulfur powder, 1 gallon water.
Preparation: Mix sulfur powder with water. Spray on affected plants every 7-10 days.

Garlic Spray:
Ingredients: 10-12 cloves garlic, 1 quart water, 1 teaspoon liquid soap.
Preparation: Blend garlic with water, let sit overnight, strain, and add soap. Spray on affected plants every 7-10 days.
''',
    },
    {
      'title': 'Anthracnose',
      'image': 'assets/anthracnose.webp',
      'symptoms': 'Dark, sunken lesions on leaves, stems, flowers, or fruits.',
      'precautions': '''
1. Remove and destroy infected plant debris.
2. Avoid overhead watering.
3. Use disease-free seeds and plants.''',
      'organicPesticides': '''
Cinnamon Spray:
Ingredients: 1 tablespoon cinnamon powder, 1 quart water.
Preparation: Mix cinnamon powder in water, let sit for a few hours, strain if necessary. Spray on affected plants every 7-10 days.

Horsetail Tea Spray:
Ingredients: 1 cup dried horsetail, 1 gallon water.
Preparation: Boil horsetail in water for 30 minutes, let cool, strain. Dilute with water (1:5 ratio) and spray on plants weekly.''',
    },
    {
      'title': 'Downy Mildew',
      'image': 'assets/downy_mildew.webp',
      'symptoms': 'Yellow or white patches on the upper surface of leaves, with a downy growth on the underside.',
      'precautions': '''
1. Improve air circulation by proper spacing and pruning.
2. Avoid overhead watering.
3. Use resistant plant varieties.''',
      'organicPesticides': '''
Hydrogen Peroxide Spray:
Ingredients: 1 tablespoon hydrogen peroxide (3%), 1 quart water.
Preparation: Mix hydrogen peroxide and water. Spray on plants every few days.

Chamomile Tea Spray:
Ingredients: 4 chamomile tea bags, 2 cups boiling water.
Preparation: Steep tea bags in boiling water until cool, strain. Spray on plants every few days.''',
    },
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < messages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _searchDisease(String query) {
    final filteredDiseases = diseases.where((disease) {
      final title = disease['title']!.toLowerCase();
      final symptoms = disease['symptoms']!.toLowerCase();
      final searchQuery = query.toLowerCase();

      return title.contains(searchQuery) || symptoms.contains(searchQuery);
    }).toList();

    if (filteredDiseases.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DiseasePage(
            userName: widget.userName,
            userEmail: widget.userEmail,
            diseases: filteredDiseases,
          ),
        ),
      );
    } else {
      // Show a message or handle the case when no diseases are found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No matching diseases found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organic Pests'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                    onViewProfile: widget.onViewProfile,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.local_florist),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DiseasePage(
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                    diseases: diseases,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonalDetailsPage(
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout logic or navigate to the signup page
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your disease here...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSubmitted: (query) {
                    _searchDisease(query);
                  },
                ),
              ),
              Text(
                'Usage Tips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 50,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        messages[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(messages.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    height: 8.0,
                    width: _currentPage == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/farmer.webp', // Replace with your farmer image path
                height: 200,
              ),
              SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Text(
                    'Organic is best..!!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
