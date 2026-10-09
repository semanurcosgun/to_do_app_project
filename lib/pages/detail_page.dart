
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/constants/constants.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailPage extends StatefulWidget {
  final TaskModel task;

  const DetailPage({super.key, required this.task});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
  }

  Future<void> _toggleTask() async {
    final oldValue = widget.task.isCompleted;

    setState(() {
      widget.task.isCompleted = !oldValue;
    });

    try {
      await _localStorage.updateTask(task: widget.task);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        widget.task.isCompleted = oldValue;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('task_update_error'.tr()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8FB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'task_detail'.tr(),
          style: Constants.appBarTextStyle(),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GÖREV BAŞLIĞI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Constants.pastelPink,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFD68EAC),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      Constants.capitalizeWords(task.name),
                      style: Constants.taskDetailTitleStyle(),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      task.isCompleted
                          ? 'completed'.tr()
                          : 'pending'.tr(),
                      style: Constants.taskStatusStyle(
                        task.isCompleted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // GÖREV BİLGİLERİ
              Text(
                'task_information'.tr(),
                style: Constants.sectionTitleStyle(),
              ),

              const SizedBox(height: 14),

              // TARİH VE SAAT KARTLARI
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _infoCard(
                    icon: Icons.calendar_today,
                    title: 'created_date'.tr(),
                    value: DateFormat('dd.MM.yyyy')
                        .format(task.createdAt),
                    color: Constants.pastelPurple,
                  ),

                  const SizedBox(height: 12),

                  _infoCard(
                    icon: Icons.access_time,
                    title: 'time'.tr(),
                    value: DateFormat('HH:mm')
                        .format(task.createdAt),
                    color: Constants.pastelCream,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // TAMAMLAMA BUTONU
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _toggleTask,
                  icon: Icon(
                    task.isCompleted
                        ? Icons.undo
                        : Icons.check_circle_outline,
                  ),
                  label: Text(
                    task.isCompleted
                        ? 'mark_incomplete'.tr()
                        : 'complete_task'.tr(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryPink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,

      // Sabit height yerine minimum yükseklik
      constraints: const BoxConstraints(
        minHeight: 135,
      ),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Constants.darkText,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: Constants.infoTitleStyle(),
          ),

          const SizedBox(height: 5),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              softWrap: false,
              style: Constants.infoTextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
