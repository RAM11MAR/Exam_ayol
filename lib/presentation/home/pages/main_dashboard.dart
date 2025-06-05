import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _buildAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "KO'RISHNI DAVOM ETISH",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildContinueWatchingSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "KATEGORIYALAR",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildCategoriesSection(),
            _buildAllCategoriesButton(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Ijtimoiy tarmoqlarimiz :",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildSocialMediaSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "INTERVYULAR",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            _buildInterviewsSection(),
            _buildAllInterviewsButton(),
            _buildCtaBanner(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return ClipPath(
      clipper: _AppBarClipper(),
      child: Container(
        color: const Color(0xFFF5365C),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              const Text(
                "Salom , Mohinur",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/heart_solid.svg',
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueWatchingSection() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(right: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/images/socials_main.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Yangi',
                        style: TextStyle(color: Color(0xFFF5365C), fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${index + 1} kun',
                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Kunlik taom tayyorlash bo'yicha boshlang'ich kurs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Dastur: Mohinur Ahmedova",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Qandolatchilik', 'icon': 'assets/icons/qandolatchilik.svg', 'color': const Color(0xFFFEE8EE)},
      {'name': 'Dizayn asoslari', 'icon': 'assets/icons/dizayn.svg', 'color': const Color(0xFFE8F6FF)},
      {'name': 'Psixologiya', 'icon': 'assets/icons/psixologiya.svg', 'color': const Color(0xFFFFF7E0)},
      {'name': 'Vizajist', 'icon': 'assets/icons/vizajist.svg', 'color': const Color(0xFFE6FFF2)},
      {'name': 'Smm', 'icon': 'assets/icons/smm.svg', 'color': const Color(0xFFFEE8EE)},
      {'name': 'Dasturlash', 'icon': 'assets/icons/dasturlash.svg', 'color': const Color(0xFFE8F6FF)},
    ];

    return Container(
      color: const Color(0xFFFDEBF1),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryName: categories[index]['name']!,
            iconPath: categories[index]['icon']!,
            totalHours: 'jami 144 dars',
            backgroundColor: categories[index]['color']!,
          );
        },
      ),
    );
  }

  Widget _buildAllCategoriesButton() {
    return Container(
      color: const Color(0xFFFDEBF1),
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFF5365C), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            elevation: 1,
          ),
          child: const Text(
            "Barcha kategoriyalar",
            style: TextStyle(color: Color(0xFFF5365C), fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final List<Map<String, dynamic>> socialMedia = [
      {'icon': 'assets/icons/instagram.svg', 'color': const Color(0xFFD32F2F)},
      {'icon': 'assets/icons/tik_tok.svg', 'color': const Color(0xFF000000)},
      {'icon': 'assets/icons/youtube.svg', 'color': const Color(0xFFFF0000)},
      {'icon': 'assets/icons/telegram.svg', 'color': const Color(0xFF0088CC)},
      {'icon': 'assets/icons/facebook.svg', 'color': const Color(0xFF1877F2)},
    ];

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: socialMedia.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: socialMedia[index]['color'],
              child: SvgPicture.asset(
                socialMedia[index]['icon']!,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 30,
                height: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInterviewsSection() {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 2,
        itemBuilder: (context, index) {
          return InterviewCard(
            imagePath: index == 0
                ? 'assets/images/cta.png'
                : 'assets/images/images.png',
            title: index == 0
                ? "Oilaviy psixologiya asoslari."
                : "Oilaviy psixologiya boshlang'ich ta.",
            duration: "1 soat, 22 minut",
            author: "Azizaxon Toshxo'jayeva",
          );
        },
      ),
    );
  }

  Widget _buildAllInterviewsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFF5365C), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            elevation: 1,
          ),
          child: const Text(
            "Barcha intervyular",
            style: TextStyle(color: Color(0xFFF5365C), fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildCtaBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9DAB),
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/images/cta_banner.png'),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "👋 Hey, siz hali ayolar uchun foydali videolardan tayyorlaganimizga qo'shilmaganmiz!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFF5365C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  ),
                  child: const Text("Qo'shiksh", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: const Color(0xFFF5365C),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home_active.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? const Color(0xFFF5365C) : Colors.grey,
                  BlendMode.srcIn)),
          label: 'Asosiy',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/courses.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? const Color(0xFFF5365C) : Colors.grey,
                  BlendMode.srcIn)),
          label: 'Kurslar',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/search_inactive.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? const Color(0xFFF5365C) : Colors.grey,
                  BlendMode.srcIn)),
          label: 'Izlash',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/cash.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? const Color(0xFFF5365C) : Colors.grey,
                  BlendMode.srcIn)),
          label: 'Kesh',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 4 ? const Color(0xFFF5365C) : Colors.grey,
                  BlendMode.srcIn)),
          label: 'Kabinet',
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String iconPath;
  final String totalHours;
  final Color backgroundColor;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.iconPath,
    required this.totalHours,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 8),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              totalHours,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterviewCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String author;

  const InterviewCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error, color: Colors.grey, size: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          duration,
                          style: TextStyle(color: Colors.grey[700], fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.person_outline, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          author,
                          style: TextStyle(color: Colors.grey[700], fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
