{application,riak_auth_mods,
             [{description,"Third party authentication modules for Riak"},
              {vsn,"2.0.1-0-g31b8b30"},
              {modules,[riak_auth_mods_app,riak_auth_mods_pam,
                        riak_auth_mods_sup]},
              {applications,[kernel,stdlib]},
              {registered,[riak_auth_mods_sup]},
              {mod,{riak_auth_mods_app,[]}},
              {env,[]}]}.
