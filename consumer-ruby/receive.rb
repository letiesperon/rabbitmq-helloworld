require 'bunny'

connection = Bunny.new(host: 'localhost', port: '5672', automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('miqueue')

begin
  puts 'Esperando mensajes nuevos... Para salir: CTRL+C'

  queue.subscribe(block: true) do |delivery_info, properties, body|
    puts "Recibí: #{body}"
  end
rescue Interrupt
  connection.close

  exit(0)
end
