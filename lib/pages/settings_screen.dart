import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _timeFormat = '24'; // 12 atau 24 jam
  String _selectedCity = 'Jakarta';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Notification Settings
            _buildSectionHeader('Notifikasi'),
            _buildToggleTile(
              title: 'Aktifkan Notifikasi',
              subtitle: 'Terima pemberitahuan waktu sholat',
              value: _notificationEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Sound Settings
            _buildSectionHeader('Suara & Getaran'),
            _buildToggleTile(
              title: 'Suara',
              subtitle: 'Aktifkan suara notifikasi',
              value: _soundEnabled,
              onChanged: (value) {
                setState(() {
                  _soundEnabled = value;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildToggleTile(
              title: 'Getaran',
              subtitle: 'Aktifkan getaran untuk notifikasi',
              value: _vibrationEnabled,
              onChanged: (value) {
                setState(() {
                  _vibrationEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Time Format Settings
            _buildSectionHeader('Format Waktu'),
            _buildDropdownTile(
              title: 'Format Waktu',
              subtitle: 'Pilih format tampilan waktu',
              value: _timeFormat,
              items: ['12 Jam', '24 Jam'],
              values: ['12', '24'],
              onChanged: (value) {
                setState(() {
                  _timeFormat = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Location Settings
            _buildSectionHeader('Lokasi'),
            _buildDropdownTile(
              title: 'Kota',
              subtitle: 'Pilih kota untuk perhitungan waktu sholat',
              value: _selectedCity,
              items: [
                'Jakarta',
                'Bandung',
                'Surabaya',
                'Medan',
                'Yogyakarta',
                'Palembang',
                'Makassar',
              ],
              values: [
                'Jakarta',
                'Bandung',
                'Surabaya',
                'Medan',
                'Yogyakarta',
                'Palembang',
                'Makassar',
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Other Settings
            _buildSectionHeader('Lainnya'),
            _buildSettingsTile(
              icon: Icons.info,
              title: 'Tentang Aplikasi',
              subtitle: 'Versi 1.0.0',
              onTap: () {
                _showAboutDialog(context);
              },
            ),
            const SizedBox(height: 12),
            _buildSettingsTile(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi',
              subtitle: 'Baca kebijakan privasi kami',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buka halaman Kebijakan Privasi')),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildSettingsTile(
              icon: Icons.help,
              title: 'Bantuan',
              subtitle: 'Dapatkan bantuan dan dukungan',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buka halaman Bantuan')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _showLogoutConfirmation(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required List<String> values,
    required Function(String) onChanged,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.green),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                underline: const SizedBox(),
                items: List.generate(
                  items.length,
                  (index) => DropdownMenuItem(
                    value: values[index],
                    child: Text(items[index]),
                  ),
                ),
                onChanged: (newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Aplikasi'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Waktu Sholat Cerdas'),
            SizedBox(height: 8),
            Text('Versi: 1.0.0'),
            SizedBox(height: 8),
            Text('Aplikasi untuk menampilkan jadwal sholat dan arah qibla'),
            SizedBox(height: 16),
            Text(
              '© 2024 Waktu Sholat Cerdas',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Kembali ke Login Screen
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
