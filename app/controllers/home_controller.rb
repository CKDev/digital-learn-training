class HomeController < ApplicationController
  prepend_before_action :redirect_unauthenticated_subdomain_user, only: :index
  skip_before_action :authenticate_user!, only: :language_toggle

  def index
    set_locale
    @courses = Course.published.limit(2)
    @categories = get_categories
    redirect_to category_path(@categories.first) if @categories.count == 1
    @getting_started = @categories.where(tag: "Getting Started")
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
    @video_links = video_links
  end

  def language_toggle
    set_locale
    redirect_back(fallback_location: root_path)
  end

  private

  def get_categories
    categories = current_organization ? Category.where(organization: current_organization) : Category.where(organization: nil)

    categories.includes(sub_categories: :course_materials)
  end

  def redirect_unauthenticated_subdomain_user
    if !current_user && current_organization
      redirect_to "/#{current_organization.subdomain}/login"
    end
  end

  def set_locale
    requested_locale = params['lang']
    whitelisted_locales = %w(en es)
    session[:locale] = requested_locale if whitelisted_locales.include?(requested_locale)
  end

  def video_links
    @video_links ||= [
      VideoLink.new(url: 'https://vimeo.com/753981448', title: 'Connecting with Balance: Digital Habits', description: 'Digital habits and learn tips to find balance on and offline.', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/753986667', title: 'Connecting with Kindness: Online Relationships', description: 'Navigating Online communication and useful tips for connecting with kindness.', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/753993679', title: 'Connecting with Kindness: Digital Drama', description: 'Helpful and supportive ways to manage digital drama and Cyberbullying.', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/754002420', title: 'Connecting with Vigilance: Cyber Safety', description: 'How to keep personal information safe online and not fall prey to scams.', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/754024190', title: 'Connecting with Vigilance: Online Misinformation', description: 'How to navigate the world of misinformation', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/754028319', title: 'Connecting with Purpose: Digital Footprint', description: 'Is what we do online a reflection of who we are and who we want to be?', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/754031547', title: 'Digital Connections Introduction', description: 'Very brief overview of video series.', language: 'en'),
      VideoLink.new(url: 'https://vimeo.com/754459919', title: 'Connecting with Balance: Digital Habits (ES)', description: 'Digital habits and learn tips to find balance on and offline.', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754462835', title: 'Connecting with Kindness: Online Relationships (ES)', description: 'Navigating Online communication and useful tips for connecting with kindness.', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754465152', title: 'Connecting with Kindness: Digital Dram (ES)', description: 'Helpful and supportive ways to manage digital drama and Cyberbullying.', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754467123', title: 'Connecting with Vigilance: Cyber Safety (ES)', description: 'How to keep personal information safe online and not fall prey to scams.', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754470414', title: 'Connecting with Vigilance: Online Misinformation (ES)', description: 'How to navigate the world of misinformation', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754477690', title: 'Connecting with Purpose: Digital Footprint (ES)', description: 'Is what we do online a reflection of who we are and who we want to be?', language: 'es'),
      VideoLink.new(url: 'https://vimeo.com/754479432', title: 'Digital Connections Introduction (ES)', description: 'Very brief overview of video series.', language: 'es'),
    ]
  end

  class VideoLink
    attr_accessor :url, :title, :description, :language

    def initialize(url:, title:, description:, language:)
      @url = url
      @title = title
      @description = description
      @language = language
    end
  end
end
