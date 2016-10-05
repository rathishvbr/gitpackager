#!/usr/bin/ruby

ONE_LOCATION=ENV["ONE_LOCATION"]

if !ONE_LOCATION
    CONFIG_FILE="/var/lib/megam/master_key"
    LOG_FILE="/var/log/one/host_error.log"
else
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

TEMPLATE = ARGV[0]

if TEMPLATE.nil?
    log_error("Exiting due to Template is  nil.")
    exit -1
end

content = TEMPLATE
s  = Base64.decode64(content.inspect)

KEYS = Hash[*File.read(CONFIG_FILE).split(/[= \n]+/)]

STATE  = ARGV[1]
STATUS = ARGV[2]

@doc  = Nokogiri::XML(s) 

KEYS["status"] = STATUS
KEYS["state"] = STATE
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



