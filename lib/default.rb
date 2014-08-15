# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
Encoding.default_internal = Encoding::UTF_8
require 'nanoc/cachebuster'
require 'nanoc/filters/javascript_concatenator'
