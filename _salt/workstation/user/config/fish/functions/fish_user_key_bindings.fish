#!/usr/bin/fish
function fish_user_key_bindings
    bind \cc 'add_history_entry (commandline); __fish_cancel_commandline'
end

function add_history_entry
  begin
    flock 1
    and echo -- '- cmd:' (
      string replace -- \n \\n (string join ' ' $argv) | string replace \\ \\\\
    )
    and date +'  when: %s'
  end >> $__fish_user_data_dir/fish_history
  and history merge
end
