class Spree::ChangeLocaleConfiguration < Spree::Preferences::Configuration
	preference :enabled_locales, :string
end