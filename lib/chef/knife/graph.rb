require 'chef/knife'

module KnifeGraph
  class Graph < Chef::Knife
    deps do
      require 'graph'
      require 'mixlib/shellout'
    end

    banner "knife graph (options)"

    option :output,
           :short => '-O',
           :long => '--output VALUE',
           :description => 'The output filename. See http://www.graphviz.org/doc/info/output.html for supported file types. \'-\' for STDOUT (Default is knife-graph.dot)',
           :default => 'knife-graph.jpg'

    option :type,
           :short => '-t',
           :long => '--type TYPE',
           :description => 'If STDOUT is used as output, specify the output type. Ignored otherwise (Default is jpg)',
           :default => 'jpg'

    def run
      if config[:environment] and not Chef::Environment.list.find { |e, url| e == config[:environment] }
        raise "Environment '#{config[:environment]}' not found"
      end

      graph = ::Graph.new

      Chef::Role.list.each do |r, url|
        r_node = "role:#{r}"

        graph.node(r_node, r)
        graph.square << graph.node(r_node)

        role = Chef::Role.load(r)

        role.run_list_for(config[:environment]).recipe_names.each do |recipe|
          graph.edge r_node, "recipe:#{recipe}"
          graph.node("recipe:#{recipe}", recipe)
        end

        role.run_list_for(config[:environment]).role_names.each do |role_name|
          role_node = "role:#{role_name}"
          graph.node(role_node, role_name)
          graph.square << graph.node(role_node)
          graph.edge r_node, role_node
        end
      end

      # Graph dot data
      dot_str = graph.to_s

      # Determine the requested output type
      output_type = if config[:output] == '-'
                      config[:type]
                    else
                      File.extname(config[:output]).split('.').last
                    end

      # Determine the right output
      if output_type == 'dot'
        graph_data = dot_str
      else
        dot = Mixlib::ShellOut.new("dot -T#{output_type}", :input => dot_str)
        graph_data = dot.run_command.stdout
      end

      # Write the data to STDOUT or file
      if config[:output] == '-'
        print graph_data
      else
        File.open config[:output], 'w' do |f|
          f.print graph_data
        end
      end

      if config[:verbosity] > 0 and config[:output] != '-'
        ui.info("Generated #{config[:output]} for environment #{config[:environment] ? config[:environment] : '_default'}")
      end
    end
  end
end
