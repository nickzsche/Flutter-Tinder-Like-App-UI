import 'package:flutter/material.dart';
import 'message_detail_screen.dart'; // Klasör içi relatif import

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Örnek olarak 6 sohbet verisi varsayıldığı için 6 elemanlı bir liste
  // Her index'in favori olup olmadığını tutuyoruz.
  final List<bool> _favorites = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mesajlar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF416C),
              Color(0xFFFF4B2B),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Arama ve Filtre Bölümü
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Sohbet Ara...',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Tüm Mesajlar', true),
                          _buildFilterChip('Favoriler', false),
                          _buildFilterChip('Okunmamış', false),
                          _buildFilterChip('Arşiv', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white24),
              // Sohbet Listesi
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            'https://picsum.photos/60?random=$index',
                          ),
                        ),
                        tileColor: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kullanıcı $index',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _favorites[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _favorites[index]
                                    ? Colors.red
                                    : Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _favorites[index] = !_favorites[index];
                                });
                              },
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'Son mesaj içeriği...',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '12:$index PM',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF416C),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageDetailScreen(
                                userName: 'Kullanıcı $index',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(
          label,
          style: TextStyle(
            // Seçiliyse siyah, seçili değilse beyaz renkte gözüksün
            color: isSelected ? Colors.black : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white24,
        // Seçili olduğunda chip'in arkaplanı beyaz
        selectedColor: Colors.white,
        onSelected: (bool selected) {
          // Filtre işlemini burada yapabilirsin.
          // Seçili durum değişiminde setState gibi bir çağrı gerekecekse,
          // bu ChatScreen State'i içinde boolean değişkenlerle takip edebilirsiniz.
        },
      ),
    );
  }
}
