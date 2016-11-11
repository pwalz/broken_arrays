def randomize_list(server_list)
  num_servers = server_list.length

  # Pick a "random" server to be listed first.
  # Needs to be deterministic so we're not constantly rearranging the resulting list.
  start = node['macaddress'].split(":")[5].hex.to_i.modulo(num_servers)

  new_server_list = server_list[start, num_servers - start] + server_list[0, start]
  pp "new_server_list:", new_server_list
end

puts "\n######################################################################\n"
puts "Explicit single-element array - always works\n"

randomize_list( %w( server1 ) )

puts "\n######################################################################\n"
puts "Single-element array attribute, cast to Array - always works\n"

randomize_list( node['broken_arrays']['single_server_list'].to_a )

puts "\n######################################################################\n"
puts "Single-element array attribute - broken in 12.16.42\n"

randomize_list( node['broken_arrays']['single_server_list'] )

puts "\n######################################################################\n"
puts "Explicit multi-element array - always works\n"

randomize_list( %w( server2 server3 server4 ) )

puts "\n######################################################################\n"
puts "Multi-element array attribute, cast to Array - always works\n"

randomize_list( node['broken_arrays']['multiple_server_list'].to_a )

puts "\n######################################################################\n"
puts "Multi-element array attribute - broken in 12.16.42\n"

randomize_list( node['broken_arrays']['multiple_server_list'] )

puts "\n######################################################################\n"
