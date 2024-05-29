import 'package:supabase_flutter/supabase_flutter.dart';

class Data {
  final supabase = Supabase.instance.client;
  String _weeksTable = "weeks";
  String _joinTable = "weeks_talents";
  // final String _favoriteTalentTable = "favorite_talents";

  Future<List<Map<String, dynamic>>> getWeekData() async {
    final response = await supabase.from(_weeksTable).select('*').order(
          "created_at",
        );

    print(response);
    return response;
  }

  Future<List<Map<String, dynamic>>> getTalentData(int id) async {
    final response = await supabase
        .from(_joinTable)
        .select(
            'talents_info(id, name,age,image_URL,count,share_name,job,is_favorite)')
        .eq('id_week', id)
        .eq('is_done', false);

    return response;
  }

  Future<void> increaseTalentCountByOne({required id}) async {
    final data =
        await supabase.rpc('increment_count_by_id', params: {'input_id': id});
  }

  Future<void> TalentDone({required int id, required int weekId}) async {
    final data = await supabase
        .from(_joinTable)
        .update({'is_done': true})
        .eq('id_week', weekId)
        .eq('id_talent', id);
  }
}
