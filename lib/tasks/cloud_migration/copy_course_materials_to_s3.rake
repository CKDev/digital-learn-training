require 's3_uploader'

namespace :cloud_migration do
  desc "Copy all CourseMaterial Attachments to S3"
  task copy_course_materials_to_s3: :environment do

    bucket_name = "dl-training-uploads-#{Rails.env}"
    default_region = "us-west-2"

    aws = AWS.config({ region: default_region })
    s3 = AWS::S3.new(region: default_region)
    bucket = s3.buckets[bucket_name]

    uploader = S3Uploader.new(bucket)

    begin
      puts "Migrating #{CourseMaterialFile.count} CMFs to S3"
      CourseMaterialFile.find_each do |cmf|
        uploader.copy_to_s3!(cmf, attachment_name: "file")
      end

      puts "Migrating #{CourseMaterialMedia.count} CMMs to S3"
      CourseMaterialMedia.find_each do |cmm|
        uploader.copy_to_s3!(cmm, attachment_name: "media", style: "original")

        # Styles
        cmm.media.styles.each do |style|
          uploader.copy_to_s3!(cmm, attachment_name: "media", style: style[0])
        end
      end

      puts "Migrating #{Attachment.count} Course Attachments"
      Attachment.find_each do |attachment|
        uploader.copy_to_s3!(attachment, attachment_name: "document")
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
