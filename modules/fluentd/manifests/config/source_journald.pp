define fluentd::config::source_journald (
  $path        = '/run/log/journal/',
  $fluentd_tag = 'journal', # Can't be called "tag" in puppet
  $priority    = 10,
)
  {

    include 'fluentd::plugin::systemd'

    $config_template = @(EOT)
    <source>
      @type systemd
      path <%= @path %>
      tag <%= @fluentd_tag %>
      read_from_head true
      <storage>
        @type local
        persistent true
        path /var/lib/fluentd/journald_pos_<%= @name %>
      </storage>
    </source>
    |- EOT

    fluentd::config { "source-journald-${name}":
      priority => $priority,
      content  => inline_template($config_template),
    }

    $tranformer_config = @(EOT)
    <filter <%= @fluentd_tag %>.**>
              @type record_transformer
              renew_record true
              enable_ruby true
              keep_keys level,message,timestamp,journal
              <record>
                message ${record["MESSAGE"]}
                timestamp ${time.iso8601(3)}
                journal ${r=record;{'transport' => r["_TRANSPORT"], 'unit' => r["_SYSTEMD_UNIT"], 'pid' => r["_PID"], 'uid' => r["_UID"]}}
              </record>
            </filter>
    |- EOT

    fluentd::config { "tranformer-journald-${name}":
      priority => 60,
      content  => inline_template($tranformer_config)
    }
  }