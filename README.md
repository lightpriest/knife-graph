Knife Graph Plugin
==================

A knife plugin that creates a graph out of various Chef entities.

Currently the only supported output is a mapping from roles to other roles and recipes (run_list).

SUBCOMMANDS
===========

Currently, this plugin supported only one knife subcommand. More will probably be added later.

knife graph
-----------

This plugin uses graphviz's dot to render the graph to jpg. Running the following command will create the file
knife-graph.jpg with the exported data.

    knife graph # => knife-graph.jpg

A couple of options are available:

### Environment

If environment is set (-E|--environment), the plugin will use the environment specific run_list if exists. i.e. the
same resolving Chef does when executing a run_list.

### -O FILENAME, --output=FILENAME

Sets the output filename (and type according to the extension, [supported types](http://www.graphviz.org/doc/info/output.html))
If the .dot extension is used, no rendering is performed. With .dot you could take the file, perform extra manipulation
or render it using your favorite tool. Use a dash (`-`) to set output to STDOUT.

### -t TYPE, --type=TYPE

If STDOUT output is used, one can set the type. (Default is jpg)

### Examples

    knife graph -E production # => knife-graph.jpg using environment run_list of production if available
    knife graph -O knife-graph.bmp # => knife-graph.bmp
    knife graph -O knife-graph.dot # => knife-graph.dot
    knife graph -O- -tjpg > my-chef-installation.jpg # => JPG output to STDOUT

Build and Install
-----------------

    $ rake gem
    $ gem install pkg/knife-graph-VERSION.gem