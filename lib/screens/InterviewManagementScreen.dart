import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class InterviewManagementScreen extends StatefulWidget {
  const InterviewManagementScreen({Key? key}) : super(key: key);

  @override
  State<InterviewManagementScreen> createState() =>
      _InterviewManagementScreenState();
}

class _InterviewManagementScreenState extends State<InterviewManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _scheduledInterviews = [
    {
      'id': 'INT001',
      'candidate': 'Sarah Wilson',
      'position': 'Product Manager',
      'date': '2025-04-30',
      'time': '10:00 AM',
      'duration': 45,
      'type': 'Technical',
      'platform': 'Zoom',
      'link': 'https://zoom.us/j/1234567890',
      'interviewer': 'John Smith',
      'status': 'Scheduled',
    },
    {
      'id': 'INT002',
      'candidate': 'Michael Brown',
      'position': 'Backend Developer',
      'date': '2025-05-02',
      'time': '02:30 PM',
      'duration': 60,
      'type': 'Technical',
      'platform': 'Google Meet',
      'link': 'https://meet.google.com/abc-defg-hij',
      'interviewer': 'Emily Johnson',
      'status': 'Scheduled',
    },
    {
      'id': 'INT003',
      'candidate': 'Daniel Lee',
      'position': 'Frontend Developer',
      'date': '2025-04-29',
      'time': '11:15 AM',
      'duration': 30,
      'type': 'HR',
      'platform': 'Zoom',
      'link': 'https://zoom.us/j/0987654321',
      'interviewer': 'Jessica Williams',
      'status': 'Completed',
    },
  ];

  final List<String> _interviewers = [
    'John Smith',
    'Emily Johnson',
    'Jessica Williams',
    'Robert Brown',
    'Maria Garcia',
  ];

  final List<String> _interviewTypes = [
    'Technical',
    'HR',
    'Cultural Fit',
    'System Design',
    'Coding Challenge',
  ];

  final List<String> _platforms = [
    'Zoom',
    'Google Meet',
    'Microsoft Teams',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Management'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Schedule Interview'),
            Tab(text: 'Scheduled Interviews'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScheduleInterviewTab(),
          _buildScheduledInterviewsTab(),
        ],
      ),
    );
  }

  Widget _buildScheduleInterviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Candidate Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Candidate',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: [
                        'Sarah Wilson',
                        'Michael Brown',
                        'Daniel Lee',
                        'Emily Johnson',
                        'Jennifer Martinez',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a candidate';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Position',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                      ),
                      initialValue: 'Product Manager',
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interview Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Interview Type',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: _interviewTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an interview type';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Interviewer',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.people),
                      ),
                      items: _interviewers.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an interviewer';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Interview Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          DateFormat('EEEE, MMM d, yyyy').format(_selectedDate),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Start Time',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.access_time),
                            ),
                            initialValue: '10:00 AM',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a start time';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Duration (minutes)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.timer),
                            ),
                            initialValue: '45',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter duration';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Meeting Platform',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Platform',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.video_call),
                      ),
                      items: _platforms.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a platform';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Meeting Link (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.link),
                        helperText: 'Leave empty to auto-generate',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text('Auto-generate meeting link'),
                      subtitle: const Text(
                          'System will create a link and send invitations'),
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF3498DB),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text('Add to calendar'),
                      subtitle: const Text(
                          'Sync with recruiter & candidate calendars'),
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF3498DB),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Interview scheduled successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Switch to the scheduled interviews tab
                            _tabController.animateTo(1);
                          }
                        },
                        icon: const Icon(Icons.schedule),
                        label: const Text('Schedule Interview'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledInterviewsTab() {
    return Column(
      children: [
        // Calendar view
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Interview Calendar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),    ),
            ],
          ),
        ),

        // List of interviews
        Expanded( 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interviews on ${DateFormat('MMM d, yyyy').format(_selectedDate)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {},
                      tooltip: 'Filter Interviews',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _scheduledInterviews.length,
                    itemBuilder: (context, index) {
                      final interview = _scheduledInterviews[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3498DB)
                                          .withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.videocam,
                                      color: Color(0xFF3498DB),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          interview['candidate'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${interview['position']} • ${interview['type']} Interview',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: interview['status'] == 'Scheduled'
                                          ? Colors.blue.withOpacity(0.1)
                                          : Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      interview['status'],
                                      style: TextStyle(
                                        color:
                                            interview['status'] == 'Scheduled'
                                                ? Colors.blue
                                                : Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_formatDate(interview['date'])} at ${interview['time']} (${interview['duration']} min)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Interviewer: ${interview['interviewer']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    interview['platform'] == 'Zoom'
                                        ? Icons.videocam
                                        : Icons.video_call,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${interview['platform']}: ',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      interview['link'],
                                      style: const TextStyle(
                                        color: Color(0xFF3498DB),
                                        decoration: TextDecoration.underline,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Edit'),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.email),
                                      label: const Text('Resend Invites'),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: interview['status'] == 'Scheduled'
                                        ? ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(Icons.videocam),
                                            label: const Text('Join'),
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                            ),
                                          )
                                        : OutlinedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(Icons.rate_review),
                                            label: const Text('Review'),
                                            style: OutlinedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM d, yyyy').format(date);
  }
}
