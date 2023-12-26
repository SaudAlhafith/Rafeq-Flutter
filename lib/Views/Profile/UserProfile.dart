import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
// import 'package:rafeq_app/Views/Search/ContentCard.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'package:rafeq_app/Views/CustomElevatedButton.dart';

// class UserProfile extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     var authService = Provider.of<AuthService>(context);
//     var user = Provider.of<User?>(context);

//     return SafeArea(
//       child: Column(
//         children: [
//           Text(user?.uid.toString() ?? "No User"),
//           ElevatedButton(
//             onPressed: () {
//               authService.logout();
//             },
//             child: const Text('LogOut'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    var currentUser = authService.currentUser;
    var favoritesModel = Provider.of<FavoritesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue, // Example color for the app bar
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'AppFiles/Newbackground.jpg',
              fit: BoxFit.cover,
            ),
          ),


          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('https://picsum.photos/200'),
                        backgroundColor: Colors.blue,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, size: 20, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (currentUser != null)
                  FutureBuilder<Map<String, dynamic>?>(
                    future: authService.fetchUserProfile(currentUser.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              snapshot.data?['username'] ?? 'Username not found',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              snapshot.data?['email'] ?? 'Email not found',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            // ... Remaining UI elements
                          ],
                        );
                      }
                      return Text('User data not found');
                    },
                  ),
                const SizedBox(height: 30),
                const Text(
                  'Achievements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Container(
                  height: 100, // Set a fixed height for the row
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Makes the list scroll horizontally
                    children: [
                      // Gold cup for watching 10 courses
                      const AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.amber,
                        label: '10 Courses',
                      ),
                      // Silver cup for watching 5 courses
                      const AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.grey,
                        label: '5 Courses',
                      ),
                      // Bronze cup for watching 3 courses
                      const AchievementIcon(
                        iconData: Icons.emoji_events,
                        color: Colors.brown,
                        label: '3 Courses',
                      ),
                      // Add more achievements as needed
                    ],
                  ),
                ),
                // Horizontal list of achievements
                // ... Achievement list code
                const SizedBox(height: 30),
                const Text(
                  'Finished Courses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                // The GridView.builder to display courses in a grid of 3 columns
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true, // Use this to make GridView take the space of its children
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    crossAxisSpacing: 4, // Horizontal space between items
                    mainAxisSpacing: 4, // Vertical space between items
                  ),
                  itemCount: favoritesModel.favorites.length,
                  itemBuilder: (context, index) {
                    return ContentCard(video: favoritesModel.favorites[index]);
                  },
                ),
                const SizedBox(height: 30),
                // Text(currentUser?.uid.toString() ?? "No User"),
                ElevatedButton(
                  onPressed: () {
                    authService.logout();
                  },
                  child: const Text('LogOut'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ... AchievementIcon class
class AchievementIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String label;

  const AchievementIcon({
    Key? key,
    required this.iconData,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // Fixed width for each achievement icon
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final VideoCard video;

  ContentCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 5, // Add some elevation for shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Clip the image with rounded corners
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                video.thumbnailURL,
                fit: BoxFit.cover,
                width: double.infinity, // Make image take the full width of the card
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    video.channelTitle,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
