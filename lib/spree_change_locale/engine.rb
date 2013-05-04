module SpreeChangeLocale
  class Engine < Rails::Engine
    initializer "spree.change_locale.preferences", :after => ''"spree.environment" do |app|
      # Spree::FlagPromotions::Config = Spree::FlagPromotionConfiguration.new
      Spree::ChangeLocale::Config = Spree::ChangeLocaleConfiguration.new
    end
    engine_name 'spree_change_locale'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")).each do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")).each do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      I18n.send :extend, I18nExtension
    end

    config.to_prepare &method(:activate).to_proc
  end
end
