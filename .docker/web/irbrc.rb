require 'awesome_print'
require 'irb/ext/save-history'

# For better prints on console
AwesomePrint.irb!

# For save irb commands history
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['PWD']}/.irb-history"
