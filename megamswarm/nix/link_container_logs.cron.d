# This is a cron that wakes up and runs every 1 minutes.
# The cron calls a script that attachs link of the log to the  microservice log.
#
# Megam.  https://www.megam.io
#
# Copyright 2013-present, Megam systems
#
MAILTO=""
*/1 * * * * root @@MEGAM_HOME@@/megamswarm/link_container_logs
