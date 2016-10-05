#!/usr/bin/ruby

ONE_LOCATION=ENV["ONE_LOCATION"]

if !ONE_LOCATION
    CONFIG_FILE="/var/lib/megam/master_key"
    LOG_FILE="/var/log/one/vertice_error.log"
else
    CONFIG_FILE=ONE_LOCATION+"/var/config"
    LOG_FILE=ONE_LOCATION+"/var/vertice_error.log"
end

require 'nokogiri'
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
	    f.puts "[#{Time.now}][HOST #{HOST_ID}][#{level}] #{l}"
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


HOST_ID = ARGV[0]
TEMPLATE = ARGV[1]
STATE  = ARGV[2]
STATUS = ARGV[3]

if TEMPLATE.nil? && HOST_ID.nil? && STATE.nil? && STATUS.nil?
    log_error("Exiting due to parameter is  nil.")
    exit -1
end

content = TEMPLATE
s  = Base64.decode64(content.inspect)

KEYS = Hash[*File.read(CONFIG_FILE).split(/[= \n]+/)]


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

log "Hook - vertice #{STATE}  #{STATUS} stated:"

begin
   m  = Megam::Assembly.update(KEYS)
rescue Exception => e
  log_error e.to_s
  exit -1
end

log "Hook - vertice #{STATE}  #{STATUS} finished:"



