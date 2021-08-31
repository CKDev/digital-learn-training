namespace :cloud_migration do
  desc "Copy all Lesson Storylines to S3"
  task copy_storylines_to_s3: :environment do

    bucket_name = "dl-training-storylines-#{Rails.env}-zipped"
    default_region = "us-west-2"

    aws = AWS.config({ region: default_region })
    s3 = AWS::S3.new
    bucket = s3.buckets[bucket_name]

    puts "Migrating Lesson Storylines"
    Lesson.find_each do |lesson|
      filename = lesson.story_line_file_name
      s3_path = "storylines/#{lesson.id}/#{filename}"
      file = File.open(lesson.story_line.path)

      puts "Uploading #{filename}..."
      bucket.objects[s3_path].write(file, acl: :public_read)
    end
  end
end
