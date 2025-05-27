import 'package:flutter/material.dart';
import '../../services/prediction_service.dart';
import '../../dto/PredictResponseDTO.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final cgpaController = TextEditingController();
  final workHoursController = TextEditingController();

  bool suicidalThoughts = false;
  bool familyHistory = false;
  bool sleepLessThan5 = false;
  String? dietType; // 'unhealthy' hoặc 'healthy'

  String degreeGroup = 'Bachelor';
  String financialStress = 'Low';
  String region = 'North';
  String studySatisfaction = 'Neutral';
  String academicPressure = 'Low';

  PredictResponseDTO? result;
  bool loading = false;

  final Map<String, List<int>> degreeMap = {
    'Bachelor': [1, 0, 0],
    'Master': [0, 1, 0],
    'School': [0, 0, 1],
  };

  final Map<String, List<int>> stressMap = {
    'Low': [1, 0, 0],
    'High': [0, 1, 0],
    'Very High': [0, 0, 1],
  };

  final Map<String, List<int>> regionMap = {
    'North': [1, 0, 0, 0],
    'South': [0, 1, 0, 0],
    'East': [0, 0, 1, 0],
    'West': [0, 0, 0, 1],
  };

  final Map<String, List<int>> satisfactionMap = {
    'Neutral': [1, 0, 0],
    'Very Dissatisfied': [0, 1, 0],
    'Very Satisfied': [0, 0, 1],
  };

  final Map<String, List<int>> pressureMap = {
    'Low': [1, 0, 0],
    'High': [0, 1, 0],
    'Very High': [0, 0, 1],
  };

  Future<void> predict() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      result = null;
    });

    try {
      final response = await PredictService.predict(
        age: int.parse(ageController.text),
        cgpa: double.parse(cgpaController.text),
        suicidalThoughts: suicidalThoughts ? 1 : 0,
        workStudyHours: int.parse(workHoursController.text),
        familyHistoryOfMentalIllness: familyHistory ? 1 : 0,
        sleepDurationLessThan5Hours: sleepLessThan5 ? 1 : 0,
        dietaryHabitsUnhealthy: dietType == 'unhealthy' ? 1 : 0,
        dietaryHabitsHealthy: dietType == 'healthy' ? 1 : 0,
        degreeGroupBachelor: degreeMap[degreeGroup]![0],
        degreeGroupMaster: degreeMap[degreeGroup]![1],
        degreeGroupSchool: degreeMap[degreeGroup]![2],
        financialStressCategoryLow: stressMap[financialStress]![0],
        financialStressCategoryHigh: stressMap[financialStress]![1],
        financialStressCategoryVeryHigh: stressMap[financialStress]![2],
        regionNorth: regionMap[region]![0],
        regionSouth: regionMap[region]![1],
        regionEast: regionMap[region]![2],
        regionWest: regionMap[region]![3],
        studySatisfactionCategoryNeutral:
            satisfactionMap[studySatisfaction]![0],
        studySatisfactionCategoryVeryDissatisfied:
            satisfactionMap[studySatisfaction]![1],
        studySatisfactionCategoryVerySatisfied:
            satisfactionMap[studySatisfaction]![2],
        academicPressureCategoryLowPressure: pressureMap[academicPressure]![0],
        academicPressureCategoryHighPressure: pressureMap[academicPressure]![1],
        academicPressureCategoryVeryHighPressure:
            pressureMap[academicPressure]![2],
      );

      setState(() {
        result = response;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dự đoán thất bại: $e')),
      );
    }
  }

  Widget _buildResult() {
    if (loading) return const Center(child: CircularProgressIndicator());

    if (result != null) {
      bool isDepressed = result!.prediction == 1;
      double percent = result!.probDepression * 100;

      return Card(
        color: isDepressed ? Colors.red[50] : Colors.green[50],
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDepressed
                    ? 'Có nguy cơ trầm cảm'
                    : 'Không có nguy cơ trầm cảm',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDepressed ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Xác suất mắc trầm cảm: ${percent.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: items
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item.toString())))
          .toList(),
      onChanged: onChanged,
      validator: (val) => val == null ? 'Bắt buộc' : null,
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    cgpaController.dispose();
    workHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🧠 Dự đoán bệnh trầm cảm ở sinh viên')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2F2F2), Color(0xFFE0F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Tuổi'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Bắt buộc';
                    if (int.tryParse(val) == null) return 'Phải là số nguyên';
                    return null;
                  },
                ),
                TextFormField(
                  controller: cgpaController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'CGPA'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Bắt buộc';
                    if (double.tryParse(val) == null) return 'Phải là số';
                    return null;
                  },
                ),
                TextFormField(
                  controller: workHoursController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Giờ học/làm mỗi ngày'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Bắt buộc';
                    if (int.tryParse(val) == null) return 'Phải là số nguyên';
                    return null;
                  },
                ),
                const Divider(height: 24),
                CheckboxListTile(
                  title: const Text('Có ý nghĩ tự tử'),
                  value: suicidalThoughts,
                  onChanged: (v) =>
                      setState(() => suicidalThoughts = v ?? false),
                ),
                CheckboxListTile(
                  title: const Text('Tiền sử gia đình bị bệnh tâm thần'),
                  value: familyHistory,
                  onChanged: (v) => setState(() => familyHistory = v ?? false),
                ),
                CheckboxListTile(
                  title: const Text('Ngủ dưới 5 tiếng mỗi ngày'),
                  value: sleepLessThan5,
                  onChanged: (v) => setState(() => sleepLessThan5 = v ?? false),
                ),
                RadioListTile<String>(
                  title: const Text('Chế độ ăn không lành mạnh'),
                  value: 'unhealthy',
                  groupValue: dietType,
                  onChanged: (value) => setState(() => dietType = value),
                ),
                RadioListTile<String>(
                  title: const Text('Chế độ ăn lành mạnh'),
                  value: 'healthy',
                  groupValue: dietType,
                  onChanged: (value) => setState(() => dietType = value),
                ),
                const Divider(height: 24),
                _buildDropdown<String>(
                  label: 'Bằng cấp',
                  value: degreeGroup,
                  items: degreeMap.keys.toList(),
                  onChanged: (val) => setState(() => degreeGroup = val!),
                ),
                _buildDropdown<String>(
                  label: 'Căng thẳng tài chính',
                  value: financialStress,
                  items: stressMap.keys.toList(),
                  onChanged: (val) => setState(() => financialStress = val!),
                ),
                _buildDropdown<String>(
                  label: 'Khu vực',
                  value: region,
                  items: regionMap.keys.toList(),
                  onChanged: (val) => setState(() => region = val!),
                ),
                _buildDropdown<String>(
                  label: 'Mức độ hài lòng học tập',
                  value: studySatisfaction,
                  items: satisfactionMap.keys.toList(),
                  onChanged: (val) => setState(() => studySatisfaction = val!),
                ),
                _buildDropdown<String>(
                  label: 'Áp lực học tập',
                  value: academicPressure,
                  items: pressureMap.keys.toList(),
                  onChanged: (val) => setState(() => academicPressure = val!),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: loading ? null : predict,
                  icon: const Icon(Icons.psychology),
                  label: const Text('Dự đoán'),
                ),
                const SizedBox(height: 16),
                _buildResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
