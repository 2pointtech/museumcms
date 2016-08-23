class OrphanCleaner
  def self.run
    History::Video.destroy_all("(select count(*) from games_videos as rel where history_videos.id = rel.video_id) = 0 and (select count(*) from honorees_videos as rel where history_videos.id = rel.video_id) = 0 and (select count(*) from moments_videos as rel where history_videos.id = rel.video_id) = 0 and (select count(*) from pages_videos as rel where history_videos.id = rel.video_id) = 0 and (select count(*) from champs_videos as rel where history_videos.id = rel.video_id) = 0")

  end
end
