require "cmsimple/version"
require 'rails'
require 'mercury-rails'
require 'cells'
require 'carrierwave'

# dependencies we want to reduce the
# need of after codebase stabilizes
require 'spine-rails'
require 'haml-rails'
require 'formtastic'
require 'haml_coffee_assets'
require 'rmagick'

module Cmsimple
  class Configuration
    def initialize
      self.parent_controller = 'ApplicationController'
      self.template_path = 'cmsimple/templates'
      self.template_strategy = :basic
      self.asset_path = 'uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}'
    end

    attr_accessor :parent_controller, :template_path, :asset_path
    attr_writer :template_strategy

    def template_strategy
      case @template_strategy
      when :basic
        Cmsimple::TemplateResponder
      else
        @template_strategy.constantize
      end
    end
  end

  class << self
    attr_accessor :configuration

    # Configure CMSimple
    #
    def configure
      self.configuration ||= Configuration.new
      yield self.configuration
    end
  end
end

require 'cmsimple/rails'
require 'cmsimple/template_resolver'
require 'cmsimple/template_responder'
require 'cmsimple/regions_proxy'

