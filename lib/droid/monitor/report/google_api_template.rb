require 'tilt/haml'

module Droid
  module Monitor
    module GoogleApiTemplate
      class << self
        def create_graph(title, header1, data_file_path, graph_settings)
          template_path = "template_google_api_format.haml"
          default_graph_settings = { miniValue: 0, maxValue: 400, width: 800, height: 480 }

          template = Tilt::HamlTemplate.new(template_path)
          template.render(Object.new,
                          title: title,
                          header1: header1,
                          data_file_path: data_file_path,
                          graph_settings: graph_settings || default_graph_settings)
        end
      end
    end
  end
end
