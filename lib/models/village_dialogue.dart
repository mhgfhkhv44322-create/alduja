class VillageDialogue {
  final String id;
  final String villageId;
  final String speakerName;
  final String dialogue;
  final int orderIndex;

  const VillageDialogue({
    required this.id,
    required this.villageId,
    required this.speakerName,
    required this.dialogue,
    required this.orderIndex,
  });

  factory VillageDialogue.fromMap(Map<String, dynamic> map) {
    return VillageDialogue(
      id: map['id']?.toString() ?? '',
      villageId: map['village_id']?.toString() ?? '',
      speakerName:
          map['speaker_name']?.toString() ?? 'أحد أهل القرية',
      dialogue:
          map['dialogue']?.toString() ?? '',
      orderIndex:
          int.tryParse(map['order_index']?.toString() ?? '0') ?? 0,
    );
  }
}
