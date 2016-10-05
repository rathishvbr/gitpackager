#!/usr/bin/ruby

ONE_LOCATION=ENV["ONE_LOCATION"]

if !ONE_LOCATION
    RUBY_LIB_LOCATION="/usr/lib/one/ruby"
    VMDIR="/var/lib/one"
    CONFIG_FILE="/var/lib/megam/master_key"
    LOG_FILE="/var/log/one/host_error.log"
else
    RUBY_LIB_LOCATION=ONE_LOCATION+"/lib/ruby"
    VMDIR=ONE_LOCATION+"/var"
    CONFIG_FILE=ONE_LOCATION+"/var/config"
    LOG_FILE=ONE_LOCATION+"/var/host_error.log"
end

$: << RUBY_LIB_LOCATION

require 'opennebula'
include OpenNebula
require 'nokogiri'
require 'getoptlong'
require 'base64'
require 'open3'
require 'rexml/document'


require 'megam_api'
################################################################################

# logs

################################################################################
def log(msg, level="I")
    File.open(LOG_FILE, 'a') do |f|
        msg.lines do |l|
	    puts "[#{Time.now}][HOST #{HOST_ID}][#{level}] #{l}"
        end
    end
end



def log_error(msg)
    log(msg, "E")
end



def exit_error
    log_error("Exiting due to previous error.")
    exit(-1)
end


################################################################################

# Arguments

###############################################################################


TEMPLATE = ARGV[1]
content = TEMPLATE
s  = Base64.decode64(content.inspect)

KEYS = Hash[*File.read(CONFIG_FILE).split(/[= \n]+/)]
STATE  = ARGV[2]

HOST_ID = ARGV[0]

if HOST_ID.nil?
    exit -1
end

@doc  = Nokogiri::XML(s) 


case @doc.xpath("//STATE").text
when "3"
  case @doc.xpath("//LCM_STATE").text
  when "18"
  status = "power_off"
  state = "stopped"
  when "21"
  status = "SUSPENDED"
  state = "hold"
  else
    status = "unknown"
    state = "unknown"
#  we have to add for all lcm_states
  end
when "6"
   status = "deleting"
   state = "remove"
end

KEYS["status"] = status
KEYS["state"] = state

KEYS[:email]   = @doc.xpath("//ACCOUNTS_ID").text
KEYS["id"]      = @doc.xpath("//ASSEMBLY_ID").text
KEYS["asms_id"] = @doc.xpath("//ASSEMBLIES_ID").text
KEYS[:master_key] = KEYS['masterkey']
KEYS[:host] = KEYS['host']
KEYS[:org_id] = @doc.xpath("//ORG_ID").text
KEYS["org_id"] = @doc.xpath("//ORG_ID").text  #//gateway has change to get from header
 
################################################################################

# Main

################################################################################


#puts  "Hook launched:"

begin
   m  = Megam::Assembly.update(KEYS)
rescue Exception => e
log_error e.to_s
exit -1
end

log "Hook finished:"



