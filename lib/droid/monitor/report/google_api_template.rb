require 'tilt/haml'

module Droid
  module Monitor
    module GoogleApiTemplate
      class << self
        def create_graph( data_file_path, graph_opts = {})
          template_path = File.expand_path("../templates/template_google_api_format.haml", __FILE__)
          default_graph_settings = { miniValue: 0, maxValue: 400, width: 800, height: 480 }

          template = Tilt::HamlTemplate.new(template_path)
          template.render(Object.new,
                          title: graph_opts[:title],
                          header1: graph_opts[:header1],
                          data_file_path: data_file_path,
                          graph_settings: graph_opts[:graph_settings] || default_graph_settings)
        end
      end
    end
  end
end
