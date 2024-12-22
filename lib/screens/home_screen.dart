import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Sahte kullanıcılar (pravatar.cc kullanıldı)
  final List<Map<String, String>> users = [
    {
      "name": "Ahmet Yılmaz",
      "age": "25",
      "photo": "https://i.pravatar.cc/300?u=ahmet.yilmaz",
    },
    {
      "name": "Ayşe Kaya",
      "age": "23",
      "photo": "https://i.pravatar.cc/300?u=ayse.kaya",
    },
    {
      "name": "Mehmet Can",
      "age": "28",
      "photo": "https://i.pravatar.cc/300?u=mehmet.can",
    },
    {
      "name": "Fatma Demir",
      "age": "22",
      "photo": "https://i.pravatar.cc/300?u=fatma.demir",
    },
    {
      "name": "Ali Çelik",
      "age": "27",
      "photo": "https://i.pravatar.cc/300?u=ali.celik",
    },
    {
      "name": "Elif Şahin",
      "age": "21",
      "photo": "https://i.pravatar.cc/300?u=elif.sahin",
    },
    {
      "name": "Hakan Öz",
      "age": "26",
      "photo": "https://i.pravatar.cc/300?u=hakan.oz",
    },
    {
      "name": "Zeynep Güneş",
      "age": "24",
      "photo": "https://i.pravatar.cc/300?u=zeynep.gunes",
    },
    {
      "name": "Kemal Kara",
      "age": "29",
      "photo": "https://i.pravatar.cc/300?u=kemal.kara",
    },
    {
      "name": "Derya Kurt",
      "age": "22",
      "photo": "https://i.pravatar.cc/300?u=derya.kurt",
    },
    {
      "name": "Canan Çelik",
      "age": "25",
      "photo": "https://i.pravatar.cc/300?u=canan.celik",
    },
    {
      "name": "Burak Taş",
      "age": "30",
      "photo": "https://i.pravatar.cc/300?u=burak.tas",
    },
  ];

  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _swipeAnimation = AlwaysStoppedAnimation(Offset.zero);
  late Animation<double> _opacityAnimation = AlwaysStoppedAnimation(1.0);
  bool isAnimating = false;
  Offset? lastSwipeDirection; // Yeni eklenen değişken

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _swipeLeft() {
    if (currentIndex < users.length && !isAnimating) {
      isAnimating = true;
      lastSwipeDirection = const Offset(-1.5, 0); // Sol yön
      _animateSwipe(lastSwipeDirection!, 0.0, () {
        setState(() {
          currentIndex++;
          isAnimating = false;
          lastSwipeDirection = null; // Yönü sıfırla
        });
        print("${users[currentIndex - 1]["name"]} geçildi!");
      });
    }
  }

  void _swipeRight() {
    if (currentIndex < users.length && !isAnimating) {
      isAnimating = true;
      lastSwipeDirection = const Offset(1.5, 0); // Sağ yön
      _animateSwipe(lastSwipeDirection!, 0.0, () {
        setState(() {
          currentIndex++;
          isAnimating = false;
          lastSwipeDirection = null; // Yönü sıfırla
        });
        print("${users[currentIndex - 1]["name"]} beğenildi!");
      });
    }
  }

  void _animateSwipe(Offset offset, double opacity, VoidCallback onComplete) {
    setState(() {
      _swipeAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: offset,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      _opacityAnimation = Tween<double>(
        begin: 1.0,
        end: opacity,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    });

    _controller.forward().then((value) {
      onComplete();
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        title: Text(
          "Finder",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.chat_bubble, color: Colors.white, size: 28),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF06292),
              Color(0xFFAD1457),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: currentIndex < users.length
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        if (currentIndex + 1 < users.length)
                          _buildCard(users[currentIndex + 1]),
                        SlideTransition(
                          position: _swipeAnimation,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: _buildCard(users[currentIndex]),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      "Kimse Kalmadı!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.0),
              Color(0xFFFF416C).withOpacity(0.15),
              Color(0xFFFF416C).withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                onTap: _swipeLeft,
                icon: Icons.close,
                gradientColors: [
                  Color(0xFFFF416C),
                  Color(0xFFFF4B2B),
                ],
                size: 70,
                iconSize: 35,
              ),
              _buildActionButton(
                onTap: _swipeRight,
                icon: Icons.favorite,
                gradientColors: [
                  Color(0xFFFF416C),
                  Color(0xFFFF4B2B),
                ],
                size: 70,
                iconSize: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required List<Color> gradientColors,
    required double size,
    required double iconSize,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            spreadRadius: -2,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: CircleBorder(),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, String> user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 7,
                    child: Image.network(
                      user["photo"]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user["name"]}, ${user["age"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "İstanbul, Türkiye",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Hayat dolu, gezmeyi seven, yeni insanlarla tanışmaya açık biriyim 🌟",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
