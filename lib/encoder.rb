class Encoder
  include AWS::S3
  def self.run
    AWS::S3::Base.establish_connection!(
      :access_key_id     => AWS_ACCESS_KEY,
      :secret_access_key => AWS_SECRET_KEY
    )
    bucket_name = 'di-kstate'
    url_root = "http://s3.amazonaws.com/#{bucket_name}/"

    unless Service.buckets.include? bucket_name
      puts 'creating bocket'
      Bucket.create bucket_name
    end

    bucket = Bucket.find bucket_name

    puts "looking for videos"
    for video in History::Video.find_all_by_encoder_status 'uploaded'
      puts "#{video[:file]} starting"
      S3Object.store(
        video[:file],
        File.new(video.file.path),
        bucket_name,
        :access => :public_read
      )

      response = Zencoder::Job.create({:input => "#{url_root}#{video[:file]}",
        :outputs => [
          {
            :url => "#{url_root}#{File.basename(video[:file], File.extname(video[:file]))}.webm",
            :public => true,
            :thumbnails => [
              {
                "label" => "first",
                "number" => 10
              }
            ]
          }
      ]})
      video.encoder_id = response.body['id']
      video.encoder_status = 'encoding'
      video.save
    end

    puts 'looking for jobs'
    for video in History::Video.find_all_by_encoder_status 'encoding'
      puts "#{video[:file]} checking"
      response = Zencoder::Job.details(video.encoder_id)
      job = response.body['job']
      for output in job['output_media_files']
        puts job['state']
        if job['state'] == 'failed'
          video.encoder_status = 'failed'
          video.encoder_message = output['error_message']
          video.save
          S3Object.delete video[:file], bucket_name
        elsif job['state'] == 'finished'
          original_filename = video[:file]
          begin
            video.remote_file_url = "#{url_root}#{File.basename(video[:file], File.extname(video[:file]))}.webm"
            video.remote_thumbnail_url = job['thumbnails'].first['url'] unless job['thumbnails'].empty?
            video.encoder_status = 'finished'
            video.encoder_complete = true
            video.save!
          rescue
            puts $!
          end
          new_filename = video[:file]

          S3Object.delete original_filename, bucket_name
          S3Object.delete new_filename, bucket_name
        end
      end
    end
  end
end
