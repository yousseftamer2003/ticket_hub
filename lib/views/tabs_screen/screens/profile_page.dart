import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/profile/profile_provider.dart';
import 'package:ticket_hub/views/profile/edit_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<UserProvider>(context, listen: false)
            .fetchUserProfile(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: userProvider.isLoading
          ? _buildShimmerEffect()
          : user == null
              ? const Center(child: Text('Failed to load user data'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25.0),
                        decoration: const BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: user.imageLink != null
                                  ? NetworkImage(user.imageLink!)
                                  : const AssetImage('assets/profile.png')
                                      as ImageProvider,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '@${user.email.split('@')[0]}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard([
                        _buildInfoRow(Icons.person, user.name),
                        _buildInfoRow(Icons.phone, user.phone),
                        _buildInfoRow(Icons.email, user.email),
                      ]),
                      const SizedBox(height: 10),
                      _buildInfoCard([
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                  email: user.email,
                                  name: user.name,
                                  phone: user.phone,
                                ),
                              ),
                            );
                          },
                          child: _buildInfoRow(Icons.edit, 'Edit Profile',
                              showArrow: true),
                        ),
                        _buildInfoRow(Icons.wallet, 'Wallet', showArrow: true),
                        _buildInfoRow(Icons.language, 'Arabic'),
                      ]),
                    ],
                  ),
                ),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildShimmerCard(),
          const SizedBox(height: 10),
          _buildShimmerCard(),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool showArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          if (showArrow)
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}
