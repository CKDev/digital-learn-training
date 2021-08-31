namespace :cloud_migration do
  desc "Copy all CourseMaterial Attachments to S3"
  task copy_course_materials_to_s3: :environment do

    bucket_name = "dl-training-uploads-#{Rails.env}"

    s3 = AWS::S3.new
    bucket = s3.buckets[bucket_name]

    begin
      puts "Migrating #{CourseMaterialFile.count} CMFs to S3"
      CourseMaterialFile.find_each do |cmf|
        class_name = "CourseMaterialFile"
        attachment_name = "file"
        filename = cmf.file_file_name
        s3_path = "#{Rails.env}/#{class_name.downcase.pluralize}/#{attachment_name.pluralize}/#{cmf.id}/#{filename}"

        file = File.open(cmf.file.path)

        puts "Uploading #{filename}..."
        bucket.objects[s3_path].write(file, acl: :public_read)
      end

      puts "Migrating #{CourseMaterialMedia.count} CMMs to S3"
      CourseMaterialMedia.find_each do |cmm|
        class_name = "CourseMaterialMedia"
        attachment_name = "media"

        cmm.media.styles.each do |style|
          style_name = style[0]
          filename = cmm.media_file_name
          s3_path = "#{Rails.env}/#{class_name.downcase.pluralize}/#{attachment_name.pluralize}/#{cmm.id}/#{style_name}/#{filename}"

          file = File.open(cmm.media.path(style_name))

          puts "Uploading #{filename}..."
          bucket.objects[s3_path].write(file, acl: :public_read)
        end
      end

    rescue AWS::S3::Errors::NoSuchBucket => e
      puts "Creating the non-existing bucket: #{bucket_name}"
      s3.buckets.create(bucket_name)
      retry
    rescue Exception => e
      puts "Could not process materials: #{e}"
    end
  end
end
