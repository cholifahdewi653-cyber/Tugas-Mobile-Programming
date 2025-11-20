import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
  }

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
              'Kalender Sholat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Calendar Grid
            _buildCalendar(),

            const SizedBox(height: 30),

            // Selected Date Info
            _buildDateInfo(),

            const SizedBox(height: 20),

            // Jadwal Sholat untuk tanggal yang dipilih
            _buildPrayerSchedule(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstDay = DateTime(now.year, now.month, 1);
    final weekdayOfFirst = firstDay.weekday;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Month/Year Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month - 1,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_left, color: Colors.green),
                ),
                Text(
                  '${_getMonthName(now.month)} ${now.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month + 1,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_right, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Weekday Headers
            GridView.count(
              crossAxisCount: 7,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                'Sen',
                'Sel',
                'Rab',
                'Kam',
                'Jum',
                'Sab',
                'Min',
              ]
                  .map(
                    (day) => Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            // Calendar Days
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daysInMonth + weekdayOfFirst - 1,
              itemBuilder: (context, index) {
                if (index < weekdayOfFirst - 1) {
                  return Container();
                }

                final day = index - weekdayOfFirst + 2;
                final isSelected = day == _selectedDate.day &&
                    now.month == _selectedDate.month &&
                    now.year == _selectedDate.year;
                final isToday = day == now.day &&
                    now.month == now.month &&
                    now.year == now.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(now.year, now.month, day);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green
                          : isToday
                              ? Colors.green.shade100
                              : Colors.transparent,
                      border: isToday
                          ? Border.all(color: Colors.green, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo() {
    return Card(
      color: Colors.green.shade600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tanggal Dipilih',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              _getDayName(_selectedDate.weekday),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jadwal Sholat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        _buildPrayerCard('Subuh', '04:30', Icons.wb_twilight),
        _buildPrayerCard('Dzuhur', '12:15', Icons.wb_sunny),
        _buildPrayerCard('Ashar', '15:45', Icons.cloud),
        _buildPrayerCard('Maghrib', '18:20', Icons.wb_twilight),
        _buildPrayerCard('Isya', '19:45', Icons.nights_stay),
      ],
    );
  }

  Widget _buildPrayerCard(String name, String time, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  String _getDayName(int weekday) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return days[weekday - 1];
  }
}
