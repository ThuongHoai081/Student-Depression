class PredictResponseDTO {
  final int prediction;
  final double probNoDepression;
  final double probDepression;

  PredictResponseDTO({
    required this.prediction,
    required this.probNoDepression,
    required this.probDepression,
  });

  factory PredictResponseDTO.fromJson(Map<String, dynamic> json) {
    return PredictResponseDTO(
      prediction: json['prediction'] as int,
      probNoDepression: (json['prob_no_depression'] as num).toDouble(),
      probDepression: (json['prob_depression'] as num).toDouble(),
    );
  }
}
