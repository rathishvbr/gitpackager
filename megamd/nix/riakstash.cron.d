# This is a cron that wakes up and runs every 1 minutes.
# The cron calls a script that cleans up zombie assemblies and sends them
# to the deadmans chest.
#
# Megam.  https://www.megam.io
#
# Copyright 2013-present, Megam systems
#
MAILTO=""
*/1 * * * * root @@MEGAM_HOME@@/megamd/riakstash
