import 'package:dio/dio.dart';
import '../dto/PredictRequestDTO.dart';
import '../dto/PredictResponseDTO.dart';
import '../../common/constants/endpoints.dart';

class PredictService {
  static Future<PredictResponseDTO> predict({
    required int age,
    required double cgpa,
    required int suicidalThoughts,
    required int workStudyHours,
    required int familyHistoryOfMentalIllness,
    required int sleepDurationLessThan5Hours,
    required int dietaryHabitsUnhealthy,
    required int dietaryHabitsHealthy,
    required int degreeGroupBachelor,
    required int degreeGroupMaster,
    required int degreeGroupSchool,
    required int financialStressCategoryLow,
    required int financialStressCategoryHigh,
    required int financialStressCategoryVeryHigh,
    required int regionSouth,
    required int regionEast,
    required int regionNorth,
    required int regionWest,
    required int studySatisfactionCategoryNeutral,
    required int studySatisfactionCategoryVeryDissatisfied,
    required int studySatisfactionCategoryVerySatisfied,
    required int academicPressureCategoryHighPressure,
    required int academicPressureCategoryVeryHighPressure,
    required int academicPressureCategoryLowPressure,
  }) async {
    Dio dio = Dio();

    final requestDTO = PredictRequestDTO(
      age: age,
      cgpa: cgpa,
      suicidalThoughts: suicidalThoughts,
      workStudyHours: workStudyHours,
      familyHistoryOfMentalIllness: familyHistoryOfMentalIllness,
      sleepDurationLessThan5Hours: sleepDurationLessThan5Hours,
      dietaryHabitsUnhealthy: dietaryHabitsUnhealthy,
      dietaryHabitsHealthy: dietaryHabitsHealthy,
      degreeGroupBachelor: degreeGroupBachelor,
      degreeGroupMaster: degreeGroupMaster,
      degreeGroupSchool: degreeGroupSchool,
      financialStressCategoryLow: financialStressCategoryLow,
      financialStressCategoryHigh: financialStressCategoryHigh,
      financialStressCategoryVeryHigh: financialStressCategoryVeryHigh,
      regionSouth: regionSouth,
      regionEast: regionEast,
      regionNorth: regionNorth,
      regionWest: regionWest,
      studySatisfactionCategoryNeutral: studySatisfactionCategoryNeutral,
      studySatisfactionCategoryVeryDissatisfied:
          studySatisfactionCategoryVeryDissatisfied,
      studySatisfactionCategoryVerySatisfied:
          studySatisfactionCategoryVerySatisfied,
      academicPressureCategoryHighPressure:
          academicPressureCategoryHighPressure,
      academicPressureCategoryVeryHighPressure:
          academicPressureCategoryVeryHighPressure,
      academicPressureCategoryLowPressure: academicPressureCategoryLowPressure,
    );

    try {
      final response = await dio.post(
        Endpoints.predict,
        data: requestDTO.toJson(),
      );

      if (response.statusCode == 200) {
        return PredictResponseDTO.fromJson(response.data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in PredictService: $e");
      throw Exception('Failed to get prediction');
    }
  }
}
